module Kwipper
  module ActionResponders
    ROUTES = {
      [:GET, '/'] => 'home',
      [:GET, '/users/new'] => 'new_user',
      [:POST, '/users/create'] => 'create_user'
    }

    def home
      @users = User.all
      render :home
    end

    def new_user
      render :new_user
    end

    def create_user
      user = User.new @request.post_data

      if user.save
        binding.pry # debug
      else
        binding.pry # debug
      end
    end
  end
end