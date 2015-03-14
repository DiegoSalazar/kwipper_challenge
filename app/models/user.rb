module Kwipper
  class User < Model
    def self.all
      sql "SELECT * FROM users"
    end

    attr_reader :id, :username, :email, :hashed_password

    def initialize(*args)
      @id, @username, @email, @hashed_password = args
    end
  end
end