module Fixtures
  module_function

  def user(attrs = {})
    Kwipper::User.create({
      email:           attrs.fetch(:email, "test@test.com"),
      username:        attrs.fetch(:username, "test"),
      hashed_password: attrs.fetch(:hashed_password, "123")
    })
  end
end