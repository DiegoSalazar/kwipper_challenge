module Kwipper
  class Page < Model
    column :title, :to_s
    column :slug, :to_s
    column :body, :to_s
    column :raw_body, :to_s
    column :position, :to_i
    column :parent_id, :to_i
    column :created_at, :to_s

    class << self
      def find_by_slug(slug)
        where(slug: slug).first
      end

      def parents
        all "SELECT * FROM pages WHERE parent_id IS NULL OR parent_id = '0' ORDER BY position"
      end

      def all_pages
        parents.map(&:all_pages).flatten
      end

      def all(statement = "SELECT * FROM pages ORDER BY parent_id, position")
        super
      end
    end

    def parent
      @parent ||= self.class.find parent_id if parent_id
    end

    def is_parent?(page)
      parent_id == page.id
    end

    def sub_pages
      @sub_pages ||= self.class.all "SELECT * FROM pages WHERE parent_id = #{id} ORDER BY position"
    end

    def all_pages
      [self, *self.sub_pages]
    end

    def parent_title
      parent.title if parent
    end

    def update(attrs)
      attrs["body"] = Kwipper.html_escape attrs["body"].strip if attrs["body"]
      super
    end

    def body=(html)
      @body = Kwipper.html_escape html.strip
    end

    def body
      Kwipper.html_unescape @body.gsub("&amp;", "&") if @body
    end
  end
end
