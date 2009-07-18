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

    # Is the base class for all the generalized ParamChecker-classes
    # Classes inheriting from ParamChecker have to implement the method 'call'.
    # Otherwise an exception will be thrown
    # Should return true if the check is passed, otherwise false.

    class ParamChecker

      def self.call(val)
        raise "Has to be defined"        
      end

    end
  end
end