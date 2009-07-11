# Author::    Thomas Kern
# License::   MPL 1.1
# Project::   ai4r
# Url::       http://ai4r.rubyforge.org/
#
# You can redistribute it and/or modify it under the terms of
# the Mozilla Public License version 1.1  as published by the
# Mozilla Foundation at http://www.mozilla.org/MPL/MPL-1.1.txt

require File.dirname(__FILE__) + '/parameterizable_value_incorrect'
Dir[File.dirname(__FILE__) + '/default_checkers/*'].sort.each { |file| require file }

module Ai4r
  module Data
    module ParameterizableChecker

      #  overrides the initialize method by binding the old one, calling
      # it in the new 
      def self.included(base)
        old_initialize = base.instance_method(:initialize)

        bod = <<-EOV
          base.send(:define_method, :initialize) do |#{params_for_init old_initialize}|
            old_initialize.bind(self).call(#{params_for_init old_initialize})
            check_param_values
          end
        EOV
        eval bod
      end

      private

      # checks the presence of a check-key. if present and if it is a Proc, it gets called
      # if the Proc-call returns true, an exception will be raised
      def check_param_values
        self.class.get_parameters_info.each do |k, v|
          if is_a_checkable_class?(v) && !v[:check].call(self.send(k))
            raise ParameterizableValueIncorrect.new(v[:check], self.send(k))
          end
        end
      end

      # checks v for either a proc or a constant of type ParamChecker
      def is_a_checkable_class?(v)
        v.has_key?(:check) &&
                (v[:check].is_a?(Proc) || (param_checker?(v[:check])))
      end

      # checks if v is of type ParamChecker
      def param_checker?(v)
        v.is_a?(Class) && v.new.is_a?(ParamChecker)
      end

      def self.params_for_init(old_initialize)
        (1..old_initialize.arity).map {|t| "param#{t}"}.join ","
      end

    end
  end
end


# PATCH MONKEY
class Class

  # checks whether or not a method named 'initialize' has been added and if the Parameterizable-module is included
  # if so, it includes the ParameterizableChecker-module
  def method_added(method_name)
    if method_name.to_s == "initialize" && self.include?(Ai4r::Data::Parameterizable) && @included_param_checker.nil? #&& !self.include?(Ai4r::Data::ParameterizableChecker)
      @included_param_checker = true
      self.send :include, Ai4r::Data::ParameterizableChecker
    end
  end

end