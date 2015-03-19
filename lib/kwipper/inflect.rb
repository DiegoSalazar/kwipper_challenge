module Kwipper
  class Inflect < String
    def demodulize
      Inflect.new split('::').last
    end

    def pluralize
      Inflect.new chars.last == 's' ? self : "#{self}s"
    end

    def underscore
      Inflect.new gsub(/[a-z]([A-Z])/) { |m| m.gsub $1, "_#{$1}" }.downcase
    end
  end
end