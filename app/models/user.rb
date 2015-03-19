module Kwipper
  class User < Model
    column 'username', :to_s
    column 'email', :to_s
    column 'hashed_password', :to_s

    def self.authenticate(username, password)
      user = where(username: username).first
      user && user.hashed_password == password && user
    end
  end
end