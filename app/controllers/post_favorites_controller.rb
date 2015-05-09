module Kwipper
  class PostFavoritesController < Controller
    add_routes "POST /favorites/create" => :create

    def create
      require_login!
      
      post = Post.find params["id"]
      fave = PostFavorite.create({
        user_id: current_user.id,
        post_id: post.id,
        created_at: Time.now
      })

      redirect "/kwips/show?id=#{post.id}"
    end
  end
end