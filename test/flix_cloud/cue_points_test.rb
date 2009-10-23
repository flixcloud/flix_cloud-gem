require 'test_helper'

class FlixCloud::CuePointsTest < Test::Unit::TestCase

  should "assign to event and end up with a cue point category" do
    cue_points = FlixCloud::CuePoints.new('event' => {})
    assert cue_points.event.is_a?(FlixCloud::CuePointCategory)
  end

  should "assign to navigation and end up with a cue point category" do
    cue_points = FlixCloud::CuePoints.new('navigation' => {})
    assert cue_points.navigation.is_a?(FlixCloud::CuePointCategory)
  end

end
