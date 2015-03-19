module Kwipper
  class Comment < Model
    column 'user_id', :to_i
    column 'post_id', :to_i
    column 'content', :to_s
    column 'created_at', :to_s

    def user
      @user ||= User.find user_id
    end

    def username
      user.username
    end

    def post
      @post ||= Post.find post_id
    end    
  end
end