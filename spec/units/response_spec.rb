require "spec_helper"

describe Kwipper::Response do
  subject { described_class.new Fixtures.request }
  let(:session_cookie_name) { described_class::SESSION_COOKIE_NAME }
  let(:session_cookie_value) { subject.session_cookie_value }
  let :response_with_session do
    described_class.new Fixtures.request cookies: { session_cookie_name => "something" }
  end

  context "#info" do
    it "returns a string of the HTTP status code and message" do
      expect(subject.info).to eq "200 OK"
    end
  end

  context "#headers" do
    it "returns a hash and memoizes it" do
      expect(subject.headers).to be_a Hash
      expect(subject.headers.object_id).to be subject.headers.object_id
    end

    it "sets the session cookie if it doesn't exist in the request" do
      cookie = subject.headers["Set-Cookie"]
      expect(cookie).to match session_cookie_name
    end

    it "doesn't change the session cookie if there's one in the request" do
      expect(response_with_session.headers['Set-Cookie']).to be nil
    end
  end

  context "#set_status" do
    it "takes a symbol and sets the HTTP status code and message" do
      subject.set_status :found

      expect(subject.status_code).to be 302
      expect(subject.status_message).to eq "Found"
    end
  end

  context "#current_user" do
    let(:user) { Fixtures.user }
    let(:session) { Fixtures.session id: session_cookie_value, user_id: user.id }

    it "returns a user instance when there's a user_id in the session" do
      subject.request.cookies[session_cookie_name] = session.session_id

      expect(subject.current_user.id).to be user.id
    end

    it "returns nil if there's no session" do
      expect(subject.current_user).to be nil
    end
  end

  context "#current_session" do
    let(:session) { Fixtures.session id: session_cookie_value }

    it "returns a session instance when there's a session cookie in the request" do
      subject.request.cookies[session_cookie_name] = session.session_id

      expect(subject.current_session.session_id).to eq session.session_id
    end

    it "returns nil when theres no session cookie in the request" do
      expect(subject.current_session).to be nil
    end
  end

  context "#to_http_response" do
    it "outputs the HTTP response string with headers and a nice body" do
      subject.redirect = "/test"
      subject.set_status :found
      subject.body = "Nice"

      expect(subject.to_http_response).to eq <<-HTTP
HTTP/1.1 302 Found
Set-Cookie: kwipper_session=#{subject.session_cookie_value}; HttpOnly\r
Content-Length: 4\r
Content-Type: text/html\r
Location: /test

Nice
      HTTP
    end
  end

  context "#session_cookie_value" do
    it "gets the session cookie from the request" do
      subject.request.cookies[session_cookie_name] = "set via request cookie"

      expect(subject.session_cookie_value).to eq "set via request cookie"
    end

    it "generates a random session cookie if there's none in the request" do
      expect(subject.session_cookie_value).to eq subject.instance_variable_get :@generated_cookie_value
    end
  end

  context "#remove_session_cookie" do
    it "sets a session cookie destroyer in the response headers" do
      subject.remove_session_cookie

      expect(subject.headers["Set-Cookie"]).to match "x; expires"
    end
  end
end
