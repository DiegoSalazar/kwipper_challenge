module Kwipper
  class Model
    DB_NAME = 'kwipper'
    DB_FILE_NAME = "#{DB_NAME}.db"
    ID_COLUMN = 'id'

    UnknownAttribute = Class.new ArgumentError

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
        sql("SELECT * FROM #{table_name};").each_with_object([]) do |attrs, models|
          models << new(attr_array_to_hash(attrs))
        end
      end

      def find(id, table_name)
        attrs = sql("SELECT * FROM #{table_name} WHERE id = #{id}").first
        new attr_array_to_hash attrs
      end

      def create(attrs, table_name)
        sql "INSERT INTO #{table_name} VALUES(#{attrs.values.join ', '});"
      end

      def update(id, attrs, table_name)
        sql "UPDATE #{table_name} SET #{hash_to_key_vals attrs} WHERE id=#{id};"
      end

      def destroy(id, table_name)
        sql "DELETE FROM #{table_name} WHERE id=#{id}"
      end

      private

      def attr_array_to_hash(attrs)
        attrs.each_with_index.inject({}) do |hash, (attr_val, i)|
          hash.merge! @columns.keys[i] => attr_val
        end
      end
    end

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
      if id
        self.class.update id, attrs_for_db, table_name
      else
        self.class.create attrs_for_db, table_name
      end

      true
    rescue SQLite3::SQLException => e
      log.warn e.message
      false
    end

    def update(params, table_name)
      attrs = params.each_with_object({}) do |(k, v), attrs|
        type = self.class.columns.fetch k
        attrs[k] = normalize_value_for_db v, type
      end

      self.class.update id, attrs, table_name
      true
    rescue KeyError => e
      false
    end

    def destroy(id, table_name)
      self.class.destroy id, table_name
    end

    private

    def attrs_for_db
      self.class.columns.each_with_object({}) do |(name, type), attrs|
        value = send name
        value = generate_id if name == ID_COLUMN && value.nil?
        attrs[name] = normalize_value_for_db(value, type) unless value.nil?
      end
    end

    def hash_to_key_vals(hash)
      hash.inject([]) { |a, (k, v)| a << "#{k}=#{v}" }.join ', '
    end

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
