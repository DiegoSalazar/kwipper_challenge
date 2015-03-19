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
        log.info cmd.red
        db.execute cmd
      end

      def all(table_name)
        results = sql "SELECT * FROM #{table_name}"
        results.each_with_object [] do |attrs, models|
          models << new(attr_array_to_hash attrs)
        end
      end

      def find(id, table_name)
        where({ id: id }, table_name).first
      end

      def where(attrs, table_name)
        results = sql "SELECT * FROM #{table_name} WHERE #{hash_to_key_vals attrs}"
        results.each_with_object [] do |attrs, models|
          models << new(attr_array_to_hash attrs)
        end
      end

      def create(attrs, table_name)
        db_attrs = attrs.map { |k, v| normalize_value_for_db v, columns[k] }

        unless attrs.key? 'id'
          id = generate_id
          attrs['id'] = id
          db_attrs = [id, *db_attrs]
        end

        sql "INSERT INTO #{table_name} VALUES(#{db_attrs.join ', '})"
        new attrs
      end

      def update(id, attrs, table_name)
        sql "UPDATE #{table_name} SET #{hash_to_key_vals attrs} WHERE id=#{id}"
      end

      def destroy(id, table_name)
        sql "DELETE FROM #{table_name} WHERE id=#{id}"
      end

      def exists?(id, table_name)
        id = normalize_value_for_db id, columns['id']
        result = sql "SELECT id FROM #{table_name} WHERE id = #{id} LIMIT 1"
        result && result.first && result.first.any?
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
      attrs = params.each_with_object({}) { |(k, v), a| a[k] = v }
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
      def generate_id
        max_id_plus_1 = "SELECT (id + 1) as id FROM users ORDER BY id DESC LIMIT 1"
        result = sql(max_id_plus_1).first
        result && result.first ? result.first : 1
      end

      def attr_array_to_hash(attrs)
        attrs.each_with_index.inject({}) do |hash, (attr_val, i)|
          hash.merge! @columns.keys[i] => attr_val
        end
      end

      def hash_to_key_vals(hash)
        hash.inject [] do |a, (k, v)|
          type = columns[k]
          v = normalize_value_for_db v, type
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
