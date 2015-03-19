module Kwipper
  class UsersController < Controller
    add_routes self, {
      [:GET, '/users']          => :users,
      [:GET, '/users/new']      => :new,
      [:POST, '/users/create']  => :create,
      [:GET, '/users/edit']     => :edit,
      [:POST, '/users/update']  => :update,
      [:POST, '/users/destroy'] => :destroy,
      [:GET, '/login']          => :login
    }

    def users
      require_login!
      @users = User.all
      render :users
    end

    def new
      require_login!
      render :new_user
    end

    def create
      require_login!
      user = User.new params

      if user.save
        redirect '/users'
      else
        redirect '/users/new', :bad_request
      end
    end

    def edit
      require_login!
      @user = User.find params['id']
      render :edit_user
    end

    def update
      require_login!
      user = User.find params['id']

      if user.update params
        redirect '/users'
      else
        redirect '/users/new', :bad_request
      end
    end

    def destroy
      require_login!
      user = User.find params['id']
      user.destroy
      redirect '/users'
    end

    def login
      render :login_user
    end
  end
end
