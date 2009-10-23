class FlixCloud::CuePointCategory < FlixCloud::Record

  attr_accessor :cue_point

  def cue_point=(cue_points)
    @cue_point = cue_points && cue_points.map do |cp|
      FlixCloud::CuePoint.new(cp)
    end
  end

end
