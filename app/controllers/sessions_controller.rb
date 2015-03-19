module Kwipper
  class SessionsController < Controller
    add_routes self, {
      [:POST, '/sessions/create']  => :create,
      [:GET, '/logout'] => :destroy
    }

    def create
      @user = User.authenticate params['username'], params['password']

      if @user
        Session.create({
          'id'         => response.session_cookie_value,
          'user_id'    => @user.id,
          'created_at' => Time.now.to_s
        })

        redirect '/users'
      else
        redirect '/users/login', :bad_request
      end
    end

    def destroy
      if current_session
        current_session.destroy
        response.remove_session_cookie
      end
      redirect '/'
    end
  end
end