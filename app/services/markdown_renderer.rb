module Kwipper
  class MarkdownRenderer
    DEFAULTS = {
      autolink: true, tables: true, with_toc_data: true, fenced_code_blocks: true
    }
    attr_reader :from, :to

    def initialize(from, to, orig_from = "", options = DEFAULTS)
      @from, @to, @orig_from = from, to, orig_from
      @renderer = Redcarpet::Markdown.new CustomRenderer, options
    end

    def process(attrs)
      return attrs if skip_processing? attrs
      attrs.merge to => @renderer.render(attrs[from])
    end

    private

    def skip_processing?(attrs)
      attrs[from].to_s.empty? || attrs[from].to_s.strip == @orig_from.to_s.strip
    end
  end

  class CustomRenderer < Redcarpet::Render::HTML
    # Usage: [github-link](http://link.to.github/repo "Header")
    def link(url, title, content)
      if content == "github-link"
        GITHUB_LINK_TEMPLATE.call url, title
      else
        # make external links open in a new window
        target = url.match(/^http:\/\//) ? " target=\"_blank\"" : ""
        "<a href=\"#{url}\" title=\"#{title}\"#{target}>#{content}</a>"
      end
    end

    def block_code(code, language)
      Pygments.highlight code, lexer: language
    end
  end

  #
  # Custom Markdown Syntax Templates
  #

  GITHUB_LINK_TEMPLATE = ->(url, title) {
<<-HTML
<div class="row">
  <div class="col-sm-9">
    <h3>#{title}</h3>
  </div>
  <div class="col-sm-3">
    <div class="alert alert-info pull-right">
      <span class="fa fa-github"></span>
      See the
      <a href="#{url}" target="_blank">
        code
        <span class="fa fa-external-link"></span>
      </a>
    </div>
  </div>
</div>
HTML
  }

end
