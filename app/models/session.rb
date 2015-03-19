module Kwipper
  class Session < Model
    column 'id', :to_s
    column 'user_id', :to_i
    column 'created_at', :to_s


    def destroy
      super self.class.normalize_value_for_db(id, :to_s)
    end
  end
end