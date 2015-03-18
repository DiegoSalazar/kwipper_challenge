module Kwipper
  module SessionHelpers
    USER_COOKIE_NAME = 'kwipper_user'
    SESSION_COOKIE_NAME = 'kwipper_session'
    
    def session_header
      {}.tap { |h| h['Set-Cookie'] = session_cookie unless has_session? }
    end

    def has_session?
      request.cookies.key? SESSION_COOKIE_NAME
    end

    def session_cookie
      "#{SESSION_COOKIE_NAME}=#{SecureRandom.urlsafe_base64}; HttpOnly"
    end

    def logged_in?
      request.cookies.key? USER_COOKIE_NAME
    end

    def current_user
      User.find request.cookies.fetch(USER_COOKIE_NAME)
    end
  end
end