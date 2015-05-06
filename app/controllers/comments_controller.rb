module Kwipper
  class CommentsController < Controller
    add_routes({
      "GET /kwips/comments/new"     => :new,
      "POST /kwips/comments/create" => :create
    })

    def new
      require_login!

      @post = Post.find params["id"]
      render :new_comment
    end

    def create
      require_login!

      post = Post.find params["id"]
      comment = Comment.new({
        "user_id"    => current_user.id,
        "post_id"    => post.id,
        "created_at" => Time.now.httpdate,
        "content"    => params.fetch("content", nil)
      })

      if comment.save
        redirect "/kwips/show?id=#{post.id}"
      else
        redirect "/kwips/comments/new?id=#{post.id}", :bad_request
      end
    end
  end
end