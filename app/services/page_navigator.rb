module Kwipper
  class PageNavigator
    def initialize(current_page, all_pages)
      @current_page, @all_pages = current_page, all_pages
      @current_index = @all_pages.map(&:id).index @current_page.id
    end

    def prev
      return nil if @current_index == 0
      @all_pages[@current_index - 1]
    end

    def next
      return nil if @current_index == @all_pages.size - 1
      @all_pages[@current_index + 1]
    end
  end
end