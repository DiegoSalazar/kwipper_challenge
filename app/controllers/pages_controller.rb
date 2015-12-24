module Kwipper
  class PagesController < Controller
    layout "pages/layout"
    add_routes "GET /pages" => :index,
               "GET /pages/new" => :new,
               "POST /pages/create" => :create,
               "POST /pages/:id/update" => :update,
               "GET /pages/:id/edit" => :edit,
               "POST /pages/:id/destroy" => :destroy

    def index
      @pages = PageDecorator.wrap Page.all
      render "pages/index"
    end

    def new
      require_login!
      render "pages/new"
    end

    def edit
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
      renderer = MarkdownRenderer.new "raw_body", "body", page.raw_body

      if page.update renderer.process(params["page"])
        redirect PageDecorator.new(page).show_path
      else
        redirect "/pages/new"
      end
    end

    def destroy
      require_login!
      page = Page.find params["id"]
      page.destroy
      redirect "/pages"
    end
  end
end
