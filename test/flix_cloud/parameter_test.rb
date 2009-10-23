require 'test_helper'

class FlixCloud::ParameterTest < Test::Unit::TestCase

  should "assign to key and value" do
    parameter = FlixCloud::Parameter.new(:key => 'foo', :value => 'bar')
    assert_equal 'foo', parameter.key
    assert_equal 'bar', parameter.value
  end

end
