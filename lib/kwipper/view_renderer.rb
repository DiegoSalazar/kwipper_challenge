module Kwipper
  module ViewRenderer
    VIEWS_PATH = 'app/views'
    VIEW_EXT = '.erb'

    def render(view)
      view_file = File.join Kwipper::ROOT, VIEWS_PATH, view.to_s + VIEW_EXT
      template = ERB.new File.read(view_file)
      template.result binding
    end
  end
end