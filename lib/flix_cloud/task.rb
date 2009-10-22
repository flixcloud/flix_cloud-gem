class FlixCloud::Task < FlixCloud::Record

  attr_accessor :task_id, :state, :percent_complete

  def initialize(attrs={})
    if attrs['state']
      attrs['percent_complete'] = attrs['state'][1]
      attrs['state']            = attrs['state'][0]
    end

    super(attrs)
  end

  def failed?
    state.downcase == 'failed'
  end

  def initialized?
    state.downcase == 'initialized'
  end

  def processing?
    state.downcase == 'processing'
  end

  def successful?
    state.downcase == 'success'
  end

  def waiting?
    state.downcase == 'waiting'
  end

end
