module Kwipper
  class PostFavorite < Model
    column 'user_id', :to_i
    column 'post_id', :to_i
  end
end