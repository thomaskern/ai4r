require File.dirname(__FILE__) + '/../../lib/ai4r/data/parameterizable'



class ParameterizablePseudoClass
  include Ai4r::Data::Parameterizable

  def initialize(first, second)
    @first = first
    @second = second    
  end

end

class BaseParameterizablePseudoClass
  include Ai4r::Data::Parameterizable

  parameters_info :first => {:description => "description"}, :second => {:description => "description", :check => Proc.new{|x| !x.nil? && x.length > 5}}

  def initialize(first, second)
    @first = first
    @second = second
  end
end

class ChildEmptyParamPseudoClass < BaseParameterizablePseudoClass

end

class ChildParamPseudoClass < BaseParameterizablePseudoClass

  parameters_info :first => {:description => "description", :check => Proc.new{|x| !x.nil?}}, :second => {:description => "description"}

end

class ChildInitParamPseudoClass < BaseParameterizablePseudoClass

  parameters_info :first => {:description => "description"}, :second => {:description => "description", :check => Proc.new{|x| !x.nil?}}

  def initialize(first, second)
    @first = first
    @second = second
  end
end