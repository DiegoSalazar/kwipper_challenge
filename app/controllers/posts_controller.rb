module Kwipper
  class PostsController < Controller
    add_routes self, {
      [:GET, '/kwips']         => :posts,
      [:GET, '/kwips/new']     => :new,
      [:POST, '/kwips/create'] => :create
    }

    def posts
      @posts = Post.all
      render :posts
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