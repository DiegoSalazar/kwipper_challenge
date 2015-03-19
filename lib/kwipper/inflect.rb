module Kwipper
  class Inflect < String
    def demodulize
      split('::').last
    end

    def pluralize
      chars.last == 's' ? self : "#{self}s"
    end
  end
end