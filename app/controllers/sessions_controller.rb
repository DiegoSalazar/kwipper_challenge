module Kwipper
  module SessionsController
    Application.add_routes self, {
      [:POST, '/sessions/create']  => :create_session,
      [:GET, '/logout'] => :logout
    }

    def create_session
      user = User.authenticate params['username'], params['password']

      if user
        Session.create({
          'id'         => response.session_cookie_value,
          'user_id'    => user.id,
          'created_at' => Time.now.to_s
        })
        redirect '/users'
      else
        redirect '/users/login', :bad_request
      end
    end

    def logout
      current_session && current_session.destroy
      redirect '/'
    end
  end
end