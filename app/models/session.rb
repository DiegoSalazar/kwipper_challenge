module Kwipper
  class Session < Model
    column "id", :to_s
    column "session_id", :to_s
    column "user_id", :to_i
    column "created_at", :to_s

    def self.create(attrs)
      unless attrs.key? :session_id
        attrs["session_id"] ||= SecureRandom.urlsafe_base64
      end
      super attrs
    end

    def destroy
      super self.class.db_value_quote(id, :to_s)
    end
  end
end