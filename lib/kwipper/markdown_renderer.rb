module Kwipper
  class MarkdownRenderer
    DEFAULTS = {
      autolink: true, tables: true, with_toc_data: true, fenced_code_blocks: true
    }
    attr_reader :from, :to

    def initialize(from, to, options = DEFAULTS)
      @from, @to = from, to
      @renderer = Redcarpet::Markdown.new HighlightsCode, options
    end

    def process(attrs)
      return attrs if attrs[from].to_s.empty?
      attrs.merge to => @renderer.render(attrs[from])
    end
  end

  class HighlightsCode < Redcarpet::Render::HTML
    def block_code(code, language)
      Pygments.highlight code, lexer: language
    end
  end
end
