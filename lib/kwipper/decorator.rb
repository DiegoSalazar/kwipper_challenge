module Kwipper
  class Decorator
    def self.wrap(*objects)
      objects.flatten.map { |o| new o  }
    end

    attr_reader :object
    
    def initialize(object)
      @object = object
    end

    def method_missing(name, *args, &block)
      return super unless object.respond_to? name
      object.send name, *args, &block
    end

    def respond_to?(name)
      super || object.respond_to?(name)
    end
  end
end