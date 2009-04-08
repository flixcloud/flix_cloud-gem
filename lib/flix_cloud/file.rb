class FlixCloud::File < FlixCloud::Record

  attr_accessor :url

  record_column :parameters, 'Parameters'

  def valid?
    self.errors = []

    unless url
      self.errors << "url is required"
    end

    if parameters && !parameters.valid?
      self.errors << {:parameters => parameters.errors}
    end

    errors.empty?
  end

end
