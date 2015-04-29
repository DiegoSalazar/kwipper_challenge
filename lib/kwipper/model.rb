module Kwipper
  class Model
    DB_NAME = ENV.fetch 'DB_NAME', 'kwipper'
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
      def sql(statement)
        start_time = Time.now.to_f
        db.execute(statement).tap do
          log.debug "#{statement.red} in #{sprintf '%.8f', Time.now.to_f - start_time}s"
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
        db_attrs = attrs.map(&:first).join ', '
        db_values = attrs.map { |k, v| normalize_value_for_db v, columns[k] }.join ', '

        sql "INSERT INTO #{table_name} (#{db_attrs}) VALUES(#{db_values})"
        new attrs.merge id: db.last_insert_row_id
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
        !!(result.first && result.first.any?)
      end

      def count(statement = "SELECT COUNT(id) FROM #{table_name}")
        sql(statement).first.first
      end
    end

    attr_accessor :id

    # Takes a hash of model attributes and sets them via accessors if they exists
    def initialize(attrs = {})
      attrs.each do |name, value|
        name = name.to_s
        type = self.class.columns[name] || raise(UnknownAttribute, "#{name} for #{self}")
        send "#{name}=", value.send(type)
      end
    end

    # Saves model instance to the database
    def save
      if id
        self.class.update id, attrs_for_db
      else
        self.class.create attrs_for_db
        @id ||= self.class.db.last_insert_row_id
      end

      true
    rescue SQLite3::SQLException => e
      log.warn e.message
      false
    end

    def update(attrs)
      self.class.update id, attrs
      true
    rescue SQLite3::SQLException, KeyError => e
      log.warn "Error: \"#{e.class} #{e.message}\" in #{self}"
      false
    end

    def destroy
      self.class.destroy id
    end

    protected

    def sql(statement)
      self.class.sql statement
    end

    private

    def attrs_for_db
      self.class.columns.each_with_object({}) do |(name, _), attrs|
        value = send name
        attrs[name] = value unless value.nil?
      end
    end

    class << self
      def table_name
        Inflect.new(name).demodulize.pluralize.underscore
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
      # TODO: we should probably do SQL sanitation here too
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
