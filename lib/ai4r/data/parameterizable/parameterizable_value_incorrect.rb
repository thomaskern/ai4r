module Ai4r
  module Data
    class ParameterizableValueIncorrect < Exception

      def initialize(proc, value)
        @proc = proc
        @value = value
      end

      def message
        "Checker failed, passed value #{@value} for proc #{@proc.to_s}"
      end

    end
  end
end
