module Kwipper
  module ActionResponders
    ROUTES = {
      [:GET, '/'] => 'home',
      [:POST, '/'] => 'answer'
    }

    include TinyHtmlBuilder

    def home
      html "Kwipper" do
        p "hello from home"
      end
    end

    def answer
      html "Kwipper" do
        p "hello from answer"
      end
    end
  end
end