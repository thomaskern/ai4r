require File.dirname(__FILE__) + '/parameterizable_value_incorrect'

module Ai4r
  module Data
    module ParameterizableChecker

      #  overrides the initialize method by binding the old one, calling
      # it in the new 
      def self.included(base)
        old_initialize = base.instance_method(:initialize)
        s = []
        old_initialize.arity.times {|t| s << "param#{t}"}

        bod = <<-EOV
          base.send(:define_method, :initialize) do |#{s.join(",")}|
            old_initialize.bind(self).call(#{s.join(",")})
            check_param_values
          end
        EOV
        eval bod
      end

      # checks the presence of a check-key. if present and if it is a Proc, it gets called
      # if the Proc-call returns true, an exception will be raised
      def check_param_values
        self.class.get_parameters_info.each do |k, v|
          next unless v.has_key?(:check)
          raise ParameterizableValueIncorrect.new(v[:check], self.send(k)) unless v[:check].call(self.send(k))
        end
      end

    end
  end
end


# PATCH MONKEY
class Class

  #checks whether or not a method named 'initialize' has been added and if the Parameterizable-module is included
  # if so, it includes the ParameterizableChecker-module
  def method_added(method_name)
    if method_name.to_s == "initialize" && self.include?(Ai4r::Data::Parameterizable) && @included_param_checker.nil? #&& !self.include?(Ai4r::Data::ParameterizableChecker)
      @included_param_checker = true
      self.send :include, Ai4r::Data::ParameterizableChecker
    end
  end

end