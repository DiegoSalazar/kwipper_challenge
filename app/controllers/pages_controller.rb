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
      layout "pages/layout"
      require_login!
      render "pages/new"
    end

    def edit
      layout "pages/layout"
      require_login!

      @page = Page.find params["id"]
      render "pages/edit"
    end

    def create
      require_login!

      renderer = MarkdownRenderer.new "raw_body", "body"
      page = Page.new renderer.process(params["page"])

      if page.save
        @flash = { notice: "Created page successfully!" }
        redirect "/pages"
      else
        @flash = { error: "Problems, yo" }
        redirect "/pages/new"
      end
    end

    def update
      require_login!
      
      page = Page.find params["id"]
      renderer = MarkdownRenderer.new "raw_body", "body"

      if page.update renderer.process(params["page"])
        redirect "/pages"
      else
        redirect "/pages/new"
      end
    end
  end
end
