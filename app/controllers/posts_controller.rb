module Kwipper
  class PostsController < Controller
    add_routes self, {
      [:GET, '/kwips']         => :posts,
      [:GET, '/kwips/show']    => :show,
      [:GET, '/kwips/new']     => :new,
      [:POST, '/kwips/create'] => :create
    }

    def posts
      @paginator = Paginator.new Post, page: params['page'], per: 5, path: '/kwips'
      @posts = @paginator.get "SELECT * FROM posts ORDER BY created_at DESC"
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