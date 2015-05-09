require "spec_helper"

describe Kwipper::UsersController do
  context "#users" do
    it "gets users" do
      controller = Fixtures.controller_with_session path: "/users"
      controller.users
      users = controller.instance_variable_get :@users

      expect(users.first).to be_a Kwipper::User
    end

    it "shows the users list" do
      controller = Fixtures.controller_with_session path: "/users"
      
      expect(controller.users).to match "<h1>Users</h1>"
    end
  end

  context "#show" do
    it "shows a user" do
      user = Fixtures.user
      controller = Fixtures.controller_with_session({
        path: "/users",
        query: { "id" => user.id }
      })

      expect(controller.show).to match user.email
    end
  end

  context "#new" do
    it "shows the new user form" do
      controller = Fixtures.controller_with_session path: "/users/new"

      expect(controller.new).to match "<h1>New User</h1>"
    end
  end

  context "#create" do
    it "creates a new user" do
      username = "test-#{Time.now.to_f}"
      controller = Fixtures.controller_with_session({
        path: "/users/create",
        method: "POST",
        query: {
          "user" => {
            username: username, email: "test-#{Time.now.to_f}@test.com", hashed_password: "42"
          }
        }
      })

      expect { controller.create }.to change { Kwipper::User.count }.by 1
      expect(Kwipper::User.all.last.username).to eq username
    end

    it "redirects to the users list when the user saves" do
      controller = Fixtures.controller_with_session({
        path: "/users",
        query: {
          "user" => {
            username: "test", email: "test1@test.com", hashed_password: "42"
          }
        }
      })
      controller.create

      expect(controller.response.redirect).to eq "/users"
    end

    it "redirects to users new when user didn't save" do
      controller = Fixtures.controller_with_session path: "/users"
      controller.create

      expect(controller.response.redirect).to eq "/users/new"
    end
  end

  context "#edit" do
    it "shows the edit user form" do
      controller = Fixtures.controller_with_session({
        path: "/users/edit",
        query: { "id" => Fixtures.user.id }
      })

      expect(controller.edit).to match "<h1>Edit User</h1>"
    end
  end

  context "#update" do
    it "updates a user" do
      username = "test-#{Time.now.to_f}"
      user = Fixtures.user username: username
      controller = Fixtures.controller_with_session({
        method: "POST",
        path: "/users/update",
        post_data: {},
        query: { "id" => user.id, username: username + "x" }
      })
      controller.update

      expect(Kwipper::User.find(user.id).username).to eq username + "x"
    end
  end

  context "#destroy" do
    it "destroys a user" do
      user = Fixtures.user
      controller = Fixtures.controller_with_session({
        method: "POST",
        path: "/users/destroy",
        query: { "id" => user.id }
      })

      expect { controller.destroy }.to change { Kwipper::User.count }.by -1
    end
  end

  context "#login" do
    it "shows the login form" do
      controller = Fixtures.controller_with_session path: "/login"

      expect(controller.login).to match "Login"
    end
  end
end
