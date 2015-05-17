module Kwipper
  class PageDecorator < Decorator
    def header_title
      "#{title} - #{Kwipper::APP_TITLE}"
    end

    def open_subnav?(current_slug)
      slug == current_slug || sub_pages.map(&:slug).include?(current_slug)
    end

    def next
      @next ||= PageDecorator.new navigator.next if navigator.next
    end

    def prev
      @prev ||= PageDecorator.new navigator.prev if navigator.prev
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

    private

    def navigator
      @navigator ||= PageNavigator.new @object, Page.all_pages
    end
  end
end