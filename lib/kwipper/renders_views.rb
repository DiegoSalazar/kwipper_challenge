module Kwipper
  module RendersViews
    VIEWS_PATH = 'app/views'
    VIEW_EXT = '.erb'

    def render(view, vars = {})
      template = File.read file_path_of_view(view)
      vars.each { |name, val| instance_variable_set "@#{name}", val }
      ERB.new(template).result binding
    end

    private

    def file_path_of_view(view)
      File.join Kwipper::ROOT, VIEWS_PATH, view.to_s + VIEW_EXT
    end
  end
end