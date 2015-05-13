module Kwipper
  class User < Model
    column "username", :to_s
    column "email", :to_s
    column "hashed_password", :to_s
    column "created_at", :to_s
    column "last_login", :to_s

    def self.authenticate(username, password)
      user = where(username: username).first
      user && user.hashed_password == password && user
    end

    def favorite?(post)
      result = sql("SELECT COUNT(id) FROM post_favorites WHERE user_id = #{id} AND post_id = #{post.id} LIMIT 1").first
      result.respond_to?(:[]) && result["count"].to_i > 0
    end

    def posts
      Post.recent "SELECT * FROM posts WHERE user_id = #{id}"
    end

    # TODO
    def admin?
      true
    end
  end
end