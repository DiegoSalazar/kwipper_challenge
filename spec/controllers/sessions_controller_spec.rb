require "spec_helper"

describe Kwipper::SessionsController do
  before(:each) { Kwipper::Session.delete_all  }
  let(:user) { Fixtures.user }

  context "#create" do
    it "authenticates a user give a username and password" do
      controller = Fixtures.controller_with_session({
        method: "POST",
        path: "/sessions/create",
        user: user,
        query: {
          "username" => user.username, "password" => user.hashed_password
        }
      })
      expect(Kwipper::User).to receive(:authenticate).with(user.username, user.hashed_password).and_return user

      controller.create
    end

    context "authenticates" do
      it "creates a session" do
        request = Fixtures.request({
          method: "POST",
          path: "/sessions/create",
          user: user,
          query: {
            "username" => user.username, "password" => user.hashed_password
          }
        })
        controller = Fixtures.controller request, Kwipper::Response.new(request)
        expect(Kwipper::User).to receive(:authenticate).with(user.username, user.hashed_password).and_return user

        expect { controller.create }.to change { Kwipper::Session.count }.by 1
      end

      it "redirects to users path" do
        controller = Fixtures.controller_with_session({
          method: "POST",
          path: "/sessions/create",
          user: user,
          query: {
            "username" => user.username, "password" => user.hashed_password
          }
        })
        expect(Kwipper::User).to receive(:authenticate).with(user.username, user.hashed_password).and_return user

        controller.create

        expect(controller.response.info).to eq "302 Found"
        expect(controller.response.redirect).to eq "/users"
      end
    end

    context "fails authentication" do
      it "shows login form" do
        controller = Fixtures.controller_with_session({
          method: "POST",
          path: "/sessions/create",
          user: user
        })
        
        expect(controller.create).to match "Login"
        expect(controller.response.info).to eq "401 Unauthorized"
      end
    end
  end

  context "#destroy" do
    it "destroys the current session" do
      controller = Fixtures.controller_with_session({
        method: "GET",
        path: "/logout",
        user: user
      })

      expect { controller.destroy }.to change { Kwipper::Session.count }.by -1
    end

    it "sets a delete cookie header" do
      controller = Fixtures.controller_with_session({
        method: "GET",
        path: "/logout",
        user: user
      })
      controller.destroy

      expect(controller.response.headers["Set-Cookie"]).to match "x; expires"
    end

    it "redirects to root" do
      controller = Fixtures.controller_with_session({
        method: "GET",
        path: "/logout",
        user: user
      })
      controller.destroy

      expect(controller.response.info).to eq "302 Found"
      expect(controller.response.redirect).to eq "/"
    end
  end
end
