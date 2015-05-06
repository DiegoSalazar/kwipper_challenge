module Fixtures
  module_function

  # The values listed here are required and normally assigned by the http_parser
  def request(attrs = {})
    header_attrs = attrs.fetch :header_attrs, {}

    Kwipper::Request.new do |r|
      r.path           = attrs.fetch :path, "/test"
      r.query          = attrs.fetch :query, query: :hash
      r.headers        = attrs.fetch :headers, header_attrs
      r.cookies        = attrs.fetch :cookies, r.cookies
      r.post_data      = attrs.fetch :post_data, post_data: :hash
      r.http_method    = attrs.fetch :method, "GET"
      r.content_length = attrs.fetch :content_length, r.content_length
    end
  end

  def user(attrs = {})
    Kwipper::User.create({
      email:           attrs.fetch(:email, "test@test.com"),
      username:        attrs.fetch(:username, "test"),
      hashed_password: attrs.fetch(:hashed_password, "123")
    })
  end

  def session(attrs = {})
    Kwipper::Session.create({
      id:         attrs.fetch(:id, SecureRandom.urlsafe_base64),
      user_id:    attrs.fetch(:user_id, 0),
      created_at: Time.now.httpdate
    })
  end

  def controller(request, response)
    controller_class, _ = Kwipper::Controller::ROUTES[request.info]
    controller_class.new request, response
  end

  def controller_with_session(options = {})
    user = options.delete(:user) || Fixtures.user
    session = session(user_id: user.id)
    session_cookie = "#{Kwipper::Response::SESSION_COOKIE_NAME}=#{session.id}"
    options = {
      header_attrs: { "COOKIE" => session_cookie }
    }.merge options

    request_with_session = request options
    response = Kwipper::Response.new request_with_session

    controller request_with_session, response
  end

  def post(attrs = {})
    Kwipper::Post.create({
      user_id:    attrs.fetch(:user_id, user.id),
      content:    attrs.fetch(:content, ""),
      created_at: attrs.fetch(:created_at, Time.now.httpdate)
    })
  end
end