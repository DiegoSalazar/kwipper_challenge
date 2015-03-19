module Kwipper
  class PostFavoritesController < Controller
    add_routes self, {
      [:POST, '/favorites/create'] => :create
    }

    def create
      require_login!
      
      post = Post.find params['id']
      fave = PostFavorite.create({
        'user_id' => current_user.id,
        'post_id' => post.id
      })

      redirect "/kwips/show?id=#{post.id}"
    end
  end
end