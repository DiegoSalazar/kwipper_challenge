module Kwipper
  class SessionsController < Controller
    add_routes "POST /sessions/create" => :create,
               "GET /logout" => :destroy

    def create
      @user = User.authenticate params["username"], params["password"]

      if @user
        session = Session.create({
          session_id: response.session_cookie_value,
          user_id: @user.id,
          created_at: Time.now
        })
        redirect "/users"
      else
        @flash = { danger: "Access Denied" }
        response.set_status :unauthorized
        render :login_user
      end
    end

    def destroy
      if current_session
        current_session.destroy
        response.remove_session_cookie
      end
      redirect "/"
    end
  end
end