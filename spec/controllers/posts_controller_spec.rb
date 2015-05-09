require "spec_helper"

describe Kwipper::PostsController do
  context "#posts" do
    it "uses the paginator" do
      controller = Fixtures.controller_with_session({
        method: "GET",
        path:   "/kwips"
      })
      controller.posts
      paginator = controller.instance_variable_get :@paginator

      expect(paginator).to be_a Kwipper::Paginator
    end

    it "gets posts" do
      Fixtures.post
      controller = Fixtures.controller_with_session({
        method: "GET",
        path:   "/kwips"
      })
      controller.posts
      posts = controller.instance_variable_get :@posts
      
      expect(posts.first).to be_a Kwipper::Post
    end

    it "renders the posts list" do
      Fixtures.post # create at least one post to show the correct view
      controller = Fixtures.controller_with_session({
        method: "GET",
        path:   "/kwips"
      })
    
      expect(controller.posts).to match "<h2>Kwips</h2>"
    end
  end

  context "#show" do
    it "shows a post" do
      post = Fixtures.post content: "test content"
      controller = Fixtures.controller_with_session({
        path: "/kwips/show",
        query: { "id" => post.id },
        user:   Fixtures.user,
      })

      expect(controller.show).to match "test content"
    end
  end

  context "#new" do
    it "shows the new post form" do
      controller = Fixtures.controller_with_session path: "/kwips/new"

      expect(controller.new).to match "<h1>New Kwip</h1>"
    end
  end

  context "#create" do
    it "creates a new post" do
      user = Fixtures.user
      controller = Fixtures.controller_with_session({
        method: "POST",
        path: "/kwips/create",
        query: { "content" => "test content", "user_id" => user.id },
        user:   user,
      })

      expect { controller.create }.to change { Kwipper::Post.count }.by 1
    end

    it "redirects to the kwips path when post saved" do
      user = Fixtures.user
      controller = Fixtures.controller_with_session({
        method: "POST",
        path: "/kwips/create",
        query: { "content" => "test content", "user_id" => user.id },
        user:   user,
      })
      controller.create

      expect(controller.response.redirect).to eq "/kwips"
    end

    it "redirects to the kwips new path when post didn't save" do
      user = Fixtures.user
      controller = Fixtures.controller_with_session({
        method: "POST",
        path: "/kwips/create",
        user:   user,
      })
      controller.create

      expect(controller.response.redirect).to eq "/kwips/new"
    end
  end
end
