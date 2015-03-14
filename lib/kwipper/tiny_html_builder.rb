module Kwipper
  module TinyHtmlBuilder
    def document(title = '')
      tag 'html' do
        tag('head') { tag 'title', title } +
        tag('body') do
          yield.to_s
        end
      end
    end

    def method_missing(name, *args, &block)
      tag name, args.first, &block
    end

    private
    
    def tag(name, text = nil, attrs = {})
      "<#{name}#{html_attrs(text.is_a?(Hash) ? text : attrs)}>#{text || (yield if block_given?)}</#{name}>"
    end
    
    def html_attrs(attrs)
      attrs.empty? ? '' : ' ' + attrs.map { |k, v| %{#{k}="#{v}"} }.join(' ')
    end
  end
end
