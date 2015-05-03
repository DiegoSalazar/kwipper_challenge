require "spec_helper"

describe Kwipper::PostFavoritesController do
  context "#create" do
    it "creates a post favorite" do
      post = Fixtures.post
      controller = Fixtures.controller_with_session({
        method: "POST",
        path: "/favorites/create",
        query: { "id" => post.id }
      })

      expect { controller.create }.to change { Kwipper::PostFavorite.count }.by 1
    end

    it "redirects to the post show" do
      post = Fixtures.post
      controller = Fixtures.controller_with_session({
        method: "POST",
        path: "/favorites/create",
        query: { "id" => post.id }
      })
      controller.create

      expect(controller.response.redirect).to eq "/kwips/show?id=#{post.id}"
    end
  end
end
