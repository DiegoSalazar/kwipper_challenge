module Kwipper
  module RendersViews
    VIEWS_PATH = "app/views"
    VIEW_EXT = "erb"

    def render(view, vars = {})
      view_path = file_path_of_view view
      raise Kwipper::NoSuchViewError unless File.exists? view_path

      Kwipper.benchmark "Rendered #{view} in %s".blue do
        template = File.read view_path
        vars.each { |name, val| instance_variable_set "@#{name}", val }

        ERB.new(template).result binding
      end
    end

    private

    def file_path_of_view(view)
      Kwipper.file VIEWS_PATH, "#{view}.#{VIEW_EXT}"
    end
  end
end