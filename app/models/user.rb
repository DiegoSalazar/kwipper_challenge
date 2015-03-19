module Kwipper
  class User < Model
    column 'username', :to_s
    column 'email', :to_s
    column 'hashed_password', :to_s

    def self.authenticate(username, password)
      user = where(username: username).first
      user && user.hashed_password == password && user
    end

    def favorite?(post)
      result = sql("SELECT COUNT(id) FROM post_favorites WHERE user_id = #{id} AND post_id = #{post.id} LIMIT 1").first
      result.first && result.first > 0
    end
  end
end