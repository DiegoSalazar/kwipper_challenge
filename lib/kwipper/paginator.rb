module Kwipper
  class Paginator
    PAGE_PARAM_NAME = 'page'
    Page = Struct.new :path, :num, :current?

    attr_reader :count

    def initialize(model_class, page: 1, per: 20, path: '')
      @model_class, @page, @per = model_class, page.to_i, per.to_i
      @count = @model_class.count
      @path = path
      @page = 1 if @page < 1
      @per = 1 if @per < 1
    end

    def get(statement)
      @model_class.all "#{statement} LIMIT #{@per} OFFSET #{calc_offset}"
    end

    def pages
      @pages ||= begin
        (0...count).step(@per).each_with_index.map do |_, num|
          num += 1
          Page.new path_for(num), num, num == @page
        end
      end
    end

    def from
      calc_offset + 1
    end

    def to
      t = calc_offset + @per
      t > count ? count : t
    end

    def on_first_page?
      @page == 1
    end

    def on_last_page?
      pages.last.current?
    end

    def prev_page_path
      prev_page = current_page.num - 1
      prev_page = 1 if prev_page <= 0
      pages[prev_page-1].path
    end

    def next_page_path
      next_page = current_page.num
      next_page = pages.size - 1 if next_page >= pages.size-1
      pages[next_page].path
    end

    def current_page
      pages[@page - 1]
    end

    private

    def calc_offset
      (@page - 1) * @per
    end

    def path_for(num)
      num == 1 ? @path : add_query(PAGE_PARAM_NAME => num)
    end

    def add_query(hash)
      URI.parse(@path).tap do |p|
        hash = Rack::Utils.parse_query(p.query).merge! hash
        p.query = Rack::Utils.build_query hash
      end.to_s
    end
  end
end