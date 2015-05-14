module Kwipper
  class MarkdownRenderer
    DEFAULTS = {
      autolink: true, tables: true, with_toc_data: true, fenced_code_blocks: true
    }
    attr_reader :from, :to

    def initialize(from, to, orig_from = "", options = DEFAULTS)
      @from, @to, @orig_from = from, to, orig_from
      @renderer = Redcarpet::Markdown.new HighlightsCode, options
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

  class HighlightsCode < Redcarpet::Render::HTML
    def block_code(code, language)
      Pygments.highlight code, lexer: language
    end
  end
end
