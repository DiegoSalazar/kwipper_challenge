module Kwipper
  class User < Model
    column 'username', :to_s
    column 'email', :to_s
    column 'password', :to_s

    def self.all
      super 'users'
    end

    def self.find(id)
      super id, 'users'
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