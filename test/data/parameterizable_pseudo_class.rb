require File.dirname(__FILE__) + '/../../lib/ai4r/data/parameterizable'

class ParameterizablePseudoClass

  def initialize(first, second)
    @first = first
    @second = second    
  end

  include Ai4r::Data::Parameterizable
end