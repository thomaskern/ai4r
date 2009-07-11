# Author::    Thomas Kern
# License::   MPL 1.1
# Project::   ai4r
# Url::       http://ai4r.rubyforge.org/
#
# You can redistribute it and/or modify it under the terms of
# the Mozilla Public License version 1.1  as published by the
# Mozilla Foundation at http://www.mozilla.org/MPL/MPL-1.1.txt

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
