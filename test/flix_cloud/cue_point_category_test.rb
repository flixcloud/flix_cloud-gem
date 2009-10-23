require 'test_helper'

class FlixCloud::CuePointCategoryTest < Test::Unit::TestCase

  should "assign to cue_point and end up with an array of cue points" do
    cue_point_category = FlixCloud::CuePointCategory.new('cue_point' => [{'name' => 'foo', 'time' => 'bar'},
                                                                         {'name' => 'foo', 'time' => 'bar'}])
    assert cue_point_category.cue_point.is_a?(Array)
    assert cue_point_category.cue_point.all?{|p| p.is_a?(FlixCloud::CuePoint)}
  end

end
