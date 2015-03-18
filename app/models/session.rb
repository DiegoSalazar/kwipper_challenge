module Kwipper
  class Session < Model
    column 'id', :to_s
    column 'user_id', :to_i
    column 'created_at', :to_s

    class << self
      def find(id)
        super id, 'sessions'
      end

      def create(attrs)
        super attrs, 'sessions'
      end

      def exists?(id)
        super id, 'sessions'
      end
    end

    def destroy
      super self.class.normalize_value_for_db(id, :to_s), 'sessions'
    end
  end
end