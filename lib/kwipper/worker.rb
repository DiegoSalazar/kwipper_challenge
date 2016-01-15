module Kwipper
  class Worker
    def initialize(size = 4, klass = Thread)
      @size, @klass = size.to_i, klass
      @pool = []
    end

    def will(value, &block)
      clean_pool!

      if @pool.size < @size
        @pool << (@klass.new { block.call value })
      else
        block.call value
      end
    end

    def clean_pool!
      @pool.keep_if &:alive?
    end
  end
end