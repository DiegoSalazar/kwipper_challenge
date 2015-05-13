module Kwipper
  class Page < Model
    column :title, :to_s
    column :slug, :to_s
    column :body, :to_s
    column :parent_id, :to_i
    column :created_at, :to_s
    column :position, :to_i

    def self.find_by_slug(slug)
      where(slug: slug).first
    end

    def self.parents
      all "SELECT * FROM pages WHERE parent_id IS NULL OR parent_id = '0'"
    end

    def parent
      @parent ||= self.class.find parent_id if parent_id
    end

    def sub_pages
      @sub_pages ||= self.class.where parent_id: id
    end

    def parent_title
      parent.title if parent
    end

    def update(attrs)
      attrs["body"] = CGI.escapeHTML attrs["body"]
      super
    end

    def body=(html)
      @body = CGI.escapeHTML html
    end
  end
end
