module HerokuDelayedJobAutoscale
  module Manager
    class Stub
      def initialize(options={})
        @qty = 0
      end

      def qty
        @qty
      end

      def scale_up
        @qty += 1
      end

      def scale_down
        @qty -= 1
      end
    end
  end
end
