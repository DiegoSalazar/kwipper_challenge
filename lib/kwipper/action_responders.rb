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
        @redirect = '/'
        set_status :moved
      else
        @redirect = '/users/new'
        set_status :bad_request
      end
    end
  end
end