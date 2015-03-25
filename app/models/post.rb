module Kwipper
  class Post < Model
    column 'user_id', :to_i
    column 'content', :to_s
    column 'created_at', :to_s

    def self.recent(statement = "SELECT * FROM posts")
      all(statement).sort_by { |post| Time.parse post.created_at }.reverse
    end

    def user
      @user ||= User.find user_id
    end

    def username
      user.username
    end

    def comments
      Comment.all "SELECT * FROM comments WHERE post_id = #{id}"
    end

    def comments_count
      sql("SELECT COUNT(id) FROM comments WHERE post_id = #{id}").first.pop || 0
    end

    def faves_count
      sql("SELECT COUNT(id) FROM post_favorites WHERE post_id = #{id}").first.pop || 0
    end
  end
end