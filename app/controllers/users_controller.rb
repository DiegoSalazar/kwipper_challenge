module Kwipper
  module UsersController
    Application.add_routes self, {
      [:GET, '/users']          => :users,
      [:GET, '/users/new']      => :new_user,
      [:POST, '/users/create']  => :create_user,
      [:GET, '/users/edit']     => :edit_user,
      [:POST, '/users/update']  => :update_user,
      [:POST, '/users/destroy'] => :destroy_user,
      [:GET, '/users/login']    => :login
    }

    def users
      @users = User.all
      render :users
    end

    def new_user
      render :new_user
    end

    def create_user
      user = User.new params

      if user.save
        redirect '/users'
      else
        redirect '/users/new', :bad_request
      end
    end

    def edit_user
      @user = User.find params['id']
      render :edit_user
    end

    def update_user
      user = User.find params['id']

      if user.update params
        redirect '/users'
      else
        redirect '/users/new', :bad_request
      end
    end

    def destroy_user
      user = User.find params['id']
      user.destroy
      redirect '/users'
    end

    def login
      render :login_user
    end
  end
end
