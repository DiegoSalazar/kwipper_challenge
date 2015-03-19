module Kwipper
  class Post < Model
    column 'user_id', :to_i
    column 'content', :to_s
    column 'created_at', :to_s

    def self.recent
      all "SELECT * FROM #{table_name} ORDER BY created_at DESC"
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
      result = sql("SELECT COUNT(id) FROM comments WHERE post_id = #{id}").first
      result && result.first ? result.first : 0
    end
  end
end