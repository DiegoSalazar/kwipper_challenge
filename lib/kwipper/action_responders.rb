module Kwipper
  module ActionResponders
    ROUTES = {
      [:GET, '/'] => 'home',
      [:POST, '/'] => 'answer'
    }

    def home
      @msg = "hello HOME!"
      @users = User.all
      render :home
    end

    def answer
      @msg = "hello ANS BODY!"
      render :answer
    end
  end
end