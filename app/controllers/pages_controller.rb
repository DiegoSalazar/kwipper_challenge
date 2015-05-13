module Kwipper
  class PagesController < Controller
    add_routes "GET /pages" => :index,
               "GET /pages/new" => :new,
               "POST /pages/create" => :create,
               "POST /pages/:id/update" => :update,
               "GET /pages/:id/edit" => :edit

    def index
      require_login!
      @pages = Page.all
      render "pages/index"
    end

    def new
      require_login!
      render "pages/new"
    end

    def create
      require_login!
      page = Page.new params["page"]

      if page.save
        @flash = { notice: "Created page successfully!" }
        redirect "/pages"
      else
        @flash = { error: "Problems, yo" }
        redirect "/pages/new"
      end
    end

    def edit
      require_login!
      @page = Page.find params["id"]
      render "pages/edit"
    end

    def update
      require_login!
      page = Page.find params["id"]

      if page.update params["page"]
        @flash = { notice: "Updated page successfully!" }
        redirect "/pages"
      else
        @flash = { error: "Problems, yo" }
        redirect "/pages/new"
      end
    end
  end
end
