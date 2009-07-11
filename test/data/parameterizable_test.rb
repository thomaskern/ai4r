require 'test/unit'
require File.dirname(__FILE__) + '/../../lib/ai4r/data/parameterizable'
require File.dirname(__FILE__) + '/parameterizable_pseudo_class'

module Ai4r
  module Data
    class ParameterizableTest  < Test::Unit::TestCase

      # parameters_info
      def test_should_check_params_description_for_valid_description
        assert_raise(ParameterDescriptionMissing) { set_paramater_for_pseudo("no checks",nil,nil,nil)}
      end

      def test_should_check_description_key_set_in_params
        assert_raise(ParameterDescriptionMissing) { set_parameter_hash_for_pseudo({:first => {:text => "description"}, :second => {:text => "description"}})}        
      end


      def test_should_throw_exception_when_check_proc_is_true
        ParameterizablePseudoClass.send :parameters_info, :first => {:description => "No checks"},
                                        :second => {:description => "Nil-check", :check => Proc.new{|x| !x.nil?}}

        assert_raise(Exception, RuntimeError) { ParameterizablePseudoClass.new(1, nil) }
      end

      def test_should_override_current_param_information
        ParameterizablePseudoClass.send :parameters_info, :first => {:description => "No checks"},
                                        :second => {:description => "Nil-check", :check => Proc.new{|x| !x.nil?}}

        assert_raise(Exception, RuntimeError) { ParameterizablePseudoClass.new(1, nil) }

        ParameterizablePseudoClass.send :parameters_info, :first => {:description => "No checks"},
                                        :second => {:description => "No check"}

        assert_nothing_thrown(Exception) {ParameterizablePseudoClass.new(1, nil)}
      end

      private

      def set_parameter_hash_for_pseudo(hash)
        ParameterizablePseudoClass.send :parameters_info,hash
      end

      def set_paramater_for_pseudo(first_descr, first_check, second_descr, second_check)
        ParameterizablePseudoClass.send :parameters_info, :first => {:description => first_descr, :check => first_check},:second => {:description => second_descr, :check => second_check}
      end

    end
  end
end