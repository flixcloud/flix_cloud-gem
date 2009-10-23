class FlixCloud::CuePoint < FlixCloud::Record

  attr_accessor :name, :time, :parameter

  def parameter=(parameters)
    @parameter = parameters && parameters.map do |p|
      FlixCloud::Parameter.new(p)
    end
  end

end
