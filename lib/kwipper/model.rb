module Kwipper
  class Model
    DB_FILE_NAME = 'kwipper.db'
    DB_NAME = 'kwipper'

    def self.db
      @db ||= begin
        db_file = File.join Kwipper::ROOT, 'db', DB_FILE_NAME

        SQLite3::Database.new(db_file).tap do |db|
          db.execute "CREATE TABLE IF NOT EXISTS users(id INTEGER PRIMARY KEY, username CHAR(255), email CHAR(255), hashed_password CHAR(255))"
          db.execute "INSERT INTO users VALUES(1, 'diego', 'diego@greyrobot.com', '123')" rescue nil
        end
      end
    end

    def self.sql(cmd)
      db.execute(cmd).each_with_object([]) do |attr_array, model_array|
        model_array << new(*attr_array)
      end
    end
  end
end

# CREATE TABLE users(id INT PRIMARY KEY NOT NULL, username CHAR(255) NOT NULL, email CHAR(255) NOT NULL, hashed_password CHAR(255));

# INSERT INTO users VALUES (1, 'diego', 'diego@greyrobot.com', '123');