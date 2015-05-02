module Fixtures
  module_function

  def session(attrs = {})
    Kwipper::Session.create({
      id:         attrs.fetch(:id, SecureRandom.urlsafe_base64),
      user_id:    attrs.fetch(:user_id, 0),
      created_at: Time.now.httpdate
    })
  end
end