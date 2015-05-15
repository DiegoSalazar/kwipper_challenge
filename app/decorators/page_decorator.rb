module Kwipper
  class PageDecorator < Decorator
    def full_title
      "#{title} - #{Kwipper::APP_TITLE}"
    end

    def current?(current_slug)
      slug == current_slug || sub_pages.map(&:slug).include?(current_slug)
    end

    def show_path
      "/tutorials/#{slug}"
    end

    def edit_path
      "/pages/#{id}/edit"
    end

    def destroy_path
      "/pages/#{id}/destroy"
    end

    def slug_path(root = "/tutorials/")
      "#{root}#{slug}"
    end
  end
end