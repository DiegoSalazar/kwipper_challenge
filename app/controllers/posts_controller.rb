module Kwipper
  class PostsController < Controller
    add_routes self, {
      [:GET, '/kwips']         => :index,
      [:GET, '/kwips/show']    => :show,
      [:GET, '/kwips/new']     => :new,
      [:POST, '/kwips/create'] => :create
    }

    def index
      @posts = Post.recent
      render :posts
    end

    def show
      @post = Post.find params['id']
      @comments = @post.comments
      render :show_post
    end

    def new
      require_login!
      render :new_post
    end

    def create
      require_login!
      post = Post.new params.merge({
        'user_id'    => current_user.id,
        'created_at' => Time.now.httpdate
      })

      if post.save
        redirect '/kwips'
      else
        redirect '/kwips/new', :bad_request
      end
    end
  end
end