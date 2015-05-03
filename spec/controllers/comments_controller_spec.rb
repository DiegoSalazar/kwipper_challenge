require "spec_helper"

describe Kwipper::CommentsController do
  context "#new" do
    it "raises auth error when there's no session" do
      request = Fixtures.request path: "/kwips/comments/new"
      response = Kwipper::Response.new request
      controller = Fixtures.controller request, response
      
      expect { controller.new }.to raise_error Kwipper::AuthenticationRequired
    end

    it "finds post by id" do
      post = Fixtures.post
      controller = Fixtures.controller_with_session({
        path: "/kwips/comments/new",
        query: { "id" => post.id },
        user:   Fixtures.user,
      })
      controller.new

      expect(controller.instance_variable_get(:@post).id).to be post.id
    end

    it "renders the new comment form" do
      post = Fixtures.post
      controller = Fixtures.controller_with_session({
        path: "/kwips/comments/new",
        query: { "id" => post.id },
        user:   Fixtures.user,
      })

      expect(controller.new).to match "<h2>New Comment</h2>"
    end
  end

  context "#create" do
    it "saves new comment" do
      post = Fixtures.post
      controller = Fixtures.controller_with_session({
        method: "POST",
        path:   "/kwips/comments/create",
        user:   Fixtures.user,
        query:  { "id" => post.id, "content" => "stuff and things" },
      })
      comment = Kwipper::Comment.all.last

      expect { controller.create }.to change { post.comments_count }.by 1
      expect(comment.username).to eq user.username
      expect(comment.post.id).to be post.id
    end

    it "redirects to the post" do
      post = Fixtures.post
      controller = Fixtures.controller_with_session({
        method: "POST",
        path:   "/kwips/comments/create",
        user:   Fixtures.user,
        query:  { "id" => post.id, "content" => "stuff and things" },
      })
      controller.create

      expect(controller.response.redirect).to eq "/kwips/show?id=#{post.id}"
    end

    it "responds with HTTP bad request when comment doesn't save" do
      post = Fixtures.post
      controller = Fixtures.controller_with_session({
        method: "POST",
        path:   "/kwips/comments/create",
        user:   Fixtures.user,
        query:  { "id" => post.id }
      })
      controller.create

      expect(controller.response.info).to eq "400 Bad Request"
    end
  end
end
