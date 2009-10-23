require 'test_helper'

class FlixCloud::CuePointTest < Test::Unit::TestCase

  should "assign to name and time" do
    cue_point = FlixCloud::CuePoint.new('name' => 'foo', 'time' => 'bar')
    assert_equal 'foo', cue_point.name
    assert_equal 'bar', cue_point.time
  end

  should "assign to parameter and end up with an array of parameter" do
    cue_point = FlixCloud::CuePoint.new('parameter' => [{'key' => 'foo', 'value' => 'bar'},
                                                        {'key' => 'foo', 'value' => 'bar'}])
    assert cue_point.parameter.is_a?(Array)
    assert cue_point.parameter.all?{|p| p.is_a?(FlixCloud::Parameter)}
  end

end
