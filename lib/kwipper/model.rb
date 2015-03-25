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

      # Declare columns in the model subclass in the same order the columns
      # were created in the table. This lets us instantiate model objects
      # from arrays of field values from the db. ID columns is defaulted.
      def column(name, type)
        @columns ||= { ID_COLUMN => :to_i }
        @columns[name] = type
        attr_accessor name
      end
      attr_reader :columns

      # All SQL statements should be executed through this method
      def sql(cmd)
        start_time = Time.now.to_f
        db.execute(cmd).tap do
          log.debug "#{cmd.red} in #{sprintf '%.8f', Time.now.to_f - start_time}s"
        end
      end

      # Get records from a single table and instantiate them
      def all(statement = "SELECT * FROM #{table_name}")
        sql(statement).each_with_object [] do |attrs, models|
          models << new(attr_array_to_hash attrs)
        end
      end

      def find(id)
        where(id: id).first
      end

      def where(attrs)
        all "SELECT * FROM #{table_name} WHERE #{hash_to_key_vals attrs}"
      end

      def create(attrs)
        db_attrs = attrs.map { |k, v| normalize_value_for_db v, columns[k] }

        unless attrs.key? 'id'
          id = generate_id
          attrs['id'] = id
          db_attrs = [id, *db_attrs]
        end

        sql "INSERT INTO #{table_name} VALUES(#{db_attrs.join ', '})"
        new attrs
      end

      def update(id, attrs)
        sql "UPDATE #{table_name} SET #{hash_to_key_vals attrs} WHERE id=#{id}"
      end

      def destroy(id)
        sql "DELETE FROM #{table_name} WHERE id=#{id}"
      end

      def exists?(id)
        id = normalize_value_for_db id, columns['id']
        result = sql "SELECT id FROM #{table_name} WHERE id = #{id} LIMIT 1"
        result.first && result.first.any?
      end

      def count(statement = "SELECT COUNT(id) FROM #{table_name}")
        sql(statement).first.first
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
    def save
      if id
        self.class.update id, attrs_for_db
      else
        self.class.create a = attrs_for_db
        @id ||= a['id']
      end

      true
    rescue SQLite3::SQLException => e
      log.warn e.message
      false
    end

    def update(attrs)
      self.class.update id, attrs
      true
    rescue KeyError => e
      false
    end

    def destroy(id)
      self.class.destroy id
    end

    def sql(statement)
      self.class.sql statement
    end

    private

    def attrs_for_db
      self.class.columns.each_with_object({}) do |(name, _), attrs|
        value = send name
        value = generate_id if name == ID_COLUMN && value.nil?
        attrs[name] = value unless value.nil?
      end
    end

    def generate_id
      self.class.generate_id
    end

    class << self
      def table_name
        Inflect.new(name).demodulize.pluralize.underscore
      end

      def generate_id
        max_id_plus_1 = "SELECT (id + 1) as id FROM #{table_name} ORDER BY id DESC LIMIT 1"
        result = sql(max_id_plus_1).first
        result && result.first ? result.first : 1
      end

      def attr_array_to_hash(attrs)
        attrs.each_with_index.inject({}) do |hash, (attr_val, i)|
          hash.merge! @columns.keys[i] => attr_val
        end
      end

      # Turn a hash of attributes into a comma separated string that's
      # safe to use in a SQL statement (non int values are quoted).
      # TODO: add SQL sanitation.
      def hash_to_key_vals(hash)
        hash.inject [] do |a, (k, v)|
          v = normalize_value_for_db v, columns[k]
          a << "#{k}=#{v}"
        end.join ', '
      end

      # Non int values should be quoted when putting in a SQL statement
      def normalize_value_for_db(value, type)
        case type when :to_i
          value.to_i
        else
          "\"#{value}\""
        end
      end
    end
  end
end
