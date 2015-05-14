module Kwipper
  class PageDecorator < Decorator
    def current?(current_slug)
      slug == current_slug || sub_pages.map(&:slug).include?(current_slug)
    end

    def edit_path
      "/pages/#{id}/edit"
    end

    def slug_path(root = "/tutorials/")
      "#{root}#{slug}"
    end
  end
end