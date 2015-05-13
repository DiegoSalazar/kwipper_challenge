module Kwipper
  class Model
    DEFAULT_DB = "kwipper_development"
    DB_NAME = ENV.fetch "KWIPPER_DB_NAME", DEFAULT_DB
    ID_COLUMN = "id"

    class << self
      def db
        @db ||= PG.connect dbname: DB_NAME
      end

      # Declare columns in the model subclass in the same order the columns
      # were created in the table. This lets us instantiate model objects
      # from arrays of field values from the db. ID columns is defaulted.
      def column(name, type)
        @columns ||= { ID_COLUMN => :to_i }
        @columns[name.to_s] = type
        attr_accessor name
      end
      attr_reader :columns

      # All SQL statements should be executed through this method
      def sql(statement)
        Kwipper.benchmark "#{statement.red}; in %s".red do
          db.exec statement
        end
      end

      # Get records from a single table and instantiate them
      def all(statement = "SELECT * FROM #{table_name}")
        sql(statement).each_with_object [] do |attrs, models|
          models << new(attrs)
        end
      end

      def find(id)
        where(id: id).first
      end

      def where(attrs)
        all "SELECT * FROM #{table_name} WHERE #{hash_to_key_vals attrs}"
      end

      def create(attrs)
        attrs.reject! { |_, v| v.nil? }

        db_attrs = attrs.map(&:first).join ", "
        db_values = attrs.map { |k, v| db_value_quote v, columns[k.to_s] }.join ", "
        statement = "INSERT INTO #{table_name} (#{db_attrs}) VALUES(#{db_values}) RETURNING id"

        if (result = sql statement)
          new attrs.merge id: attrs.fetch(:id, get_id_from_create(result))
        else
          false
        end
      rescue PG::Error => e
        log.warn e.message
        false
      end

      def update(id, attrs)
        sql "UPDATE #{table_name} SET #{hash_to_key_vals attrs} WHERE id=#{id}"
      end

      def destroy(id)
        sql "DELETE FROM #{table_name} WHERE id=#{id}"
      end

      def delete_all
        sql "DELETE FROM #{table_name}"
      end

      def exists?(id)
        id = db_value_quote id, columns["id"]
        result = sql "SELECT id FROM #{table_name} WHERE id = #{id} LIMIT 1"
        !!(result.first && result.first.any?)
      end

      def count(statement = "SELECT COUNT(id) AS count FROM #{table_name}")
        sql(statement).first["count"].to_i
      end
    end

    attr_accessor :id

    # Takes a hash of model attributes and sets them via accessors if they exists
    def initialize(attrs = {})
      Hash(attrs).each do |name, value|
        name = name.to_s
        type = self.class.columns[name]

        unless self.class.columns.key? name
          log.warn "Unknown attribute #{name} for #{self}"
          next
        end

        send "#{name}=", value.send(type)
      end
    end

    # Saves model instance to the database
    def save
      if id
        self.class.update id, attrs_for_db
      else
        attrs = attrs_for_db
        attrs["created_at"] ||= Time.now
        model = self.class.create attrs
        
        model ? @id ||= model.id : (return false)
      end

      true
    rescue PG::Error => e
      log.warn e.message
      false
    end

    def update(attrs)
      self.class.update id, attrs
      true
    rescue PG::Error, KeyError => e
      log.warn "Error: \"#{e.class} #{e.message}\" in #{self}"
      false
    end

    def destroy(id = self.id)
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

      def get_id_from_create(result)
        result.first.fetch ID_COLUMN
      end

      # Turn a hash of attributes into a comma separated string that's
      # safe to use in a SQL statement (non int values are quoted).
      # TODO: add SQL sanitation.
      def hash_to_key_vals(hash)
        hash.inject [] do |a, (k, v)|
          v = db_value_quote v, columns[k.to_s]
          a << "#{k}=#{v}"
        end.join ", "
      end

      # Non int values should be quoted when putting in a SQL statement
      def db_value_quote(value, type)
        case type when :to_i
          value.to_i
        else
          "'#{db.escape value.to_s}'"
        end
      end
    end
  end
end
