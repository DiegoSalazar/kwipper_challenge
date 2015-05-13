module Kwipper
  class PageDecorator < Decorator
    def current?(current_slug)
      slug == current_slug || sub_pages.map(&:slug).include?(current_slug)
    end
  end
end