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

    # ParamNilChecker checks, whether or not the passed value
    # is nil. Returns true if it is not nil, otherwise false

    class ParamNilChecker < ParamChecker

      def self.call(val)
        !val.nil?
      end

    end
  end
end
