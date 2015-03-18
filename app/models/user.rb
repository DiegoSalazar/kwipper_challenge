module Kwipper
  class User < Model
    column 'username', :to_s
    column 'email', :to_s
    column 'hashed_password', :to_s

    class << self
      def all
        super 'users'
      end

      def find(id)
        super id, 'users'
      end

      def where(attrs, table_name = 'users')
        super attrs, table_name
      end

      def authenticate(username, password)
        user = where(username: username).first
        user && user.hashed_password == password && user
      end
    end

    def save
      super 'users'
    end

    def update(params)
      super params, 'users'
    end

    def destroy
      super id, 'users'
    end
  end
end