module Kwipper
  class User < Model
    column 'username', :to_s
    column 'email', :to_s
    column 'password', :to_s

    def self.all
      super 'users'
    end

    def save
      super 'users'
    end
  end
end