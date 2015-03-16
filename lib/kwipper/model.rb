module Kwipper
  class Model
    DB_NAME = 'kwipper'
    DB_FILE_NAME = "#{DB_NAME}.db"
    ID_COLUMN = 'id'

    attr_accessor :id

    # Takes a hash of model attributes and sets them via accessors if they exists
    def initialize(attrs = {})
      attrs.keys.each do |name|
        if self.class.columns.keys.include? name
          type = self.class.columns[name]
          send "#{name}=", attrs[name].send(type)
        else
          raise UnknownAttribute, "#{name} for #{self}"
        end
      end
    end

    # Saves model instance to the database
    def save(table_name)
      attrs = self.class.columns.each_with_object({}) do |(name, type), attrs|
        value = send name
        value = generate_id if name == ID_COLUMN && value.nil?
        attrs[name] = normalize_value_for_db(value, type) unless value.nil?
      end.compact

      s = if @id # TODO: test this
        key_vals = attrs.inject [] { |a, (k, v)| "#{k}=#{v}" }.join ', '
        "UPDATE #{table_name} SET #{key_vals} WHERE id=#{@id}"
      else
        "INSERT INTO #{table_name} VALUES(#{attrs.values.join ', '})"
      end

      self.class.sql s
      true
    rescue SQLite3::SQLException => e
      log.warn e.message
      false
    end

    class << self
      def db
        @db ||= SQLite3::Database.open File.join(Kwipper::ROOT, 'db', DB_FILE_NAME)
      end

      # Declare columns in the model class in the same order the columns
      # were created in the table. This lets us instantiate model objects
      # from arrays of field values from the db.
      def column(name, type)
        @columns ||= { ID_COLUMN => :to_i }
        @columns[name] = type
        attr_accessor name
      end
      attr_reader :columns

      def sql(cmd)
        db.execute cmd
      end

      def all(table_name)
        sql("SELECT * FROM #{table_name}").each_with_object([]) do |attrs, models|
          models << new(attr_array_to_hash(attrs))
        end
      end

      def find(id, table_name)
        attrs = sql("SELECT * FROM #{table_name} WHERE id = #{id}").first
        new attr_array_to_hash attrs
      end

      private

      def attr_array_to_hash(attrs)
        attrs.each_with_index.inject({}) do |hash, (attr_val, i)|
          hash.merge! @columns.keys[i] => attr_val
        end
      end
    end

    UnknownAttribute = Class.new ArgumentError

    private

    def normalize_value_for_db(value, type)
      case type when :to_i
        value.to_i
      else
        "\"#{value}\""
      end
    end

    def generate_id
      max_id_plus_1 = "SELECT (id + 1) as id FROM users ORDER BY id DESC LIMIT 1"
      result = self.class.sql(max_id_plus_1).first
      result && result.first ? result.first : 1
    end
  end
end
