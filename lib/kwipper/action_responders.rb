module Kwipper
  module ActionResponders
    ROUTES = {
      [:GET, '/'] => 'home',
      [:POST, '/'] => 'answer'
    }

    include TinyHtmlBuilder

    def home
      document "Kwipper" do
        h1('Kwipper') +
        hr +
        ul do
          li("hello 1") +
          li("hello 2")
        end
      end
    end

    def answer
      html "Kwipper" do
        p "hello from answer"
      end
    end
  end
end