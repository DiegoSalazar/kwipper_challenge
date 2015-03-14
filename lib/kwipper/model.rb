module Kwipper
  class Model
    DB_NAME = 'kwipper'
    DB_FILE_NAME = "#{DB_NAME}.db"

    class << self
      def db
        @db ||= SQLite3::Database.open File.join(Kwipper::ROOT, 'db', DB_FILE_NAME)
      end

      def sql(cmd)
        db.execute cmd
      end

      def all(table_name)
        sql("SELECT * FROM #{table_name}").each_with_object([]) do |attrs, models|
          models << new(*attrs)
        end
      end

      def find(id, table_name)
        new sql("SELECT * FROM #{table_name} WHERE id = #{id}")
      end
    end
  end
end
