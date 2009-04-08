class FlixCloud::FileLocations < FlixCloud::Record

  record_column :input, 'InputFile'
  record_column :output, 'OutputFile'
  record_column :watermark, 'WatermarkFile'

  def valid?
    self.errors = []

    if input
      unless input.valid?
        self.errors << {:input => input.errors}
      end
    else
      self.errors << "input is required"
    end

    if output
      unless output.valid?
        self.errors << {:output => output.errors}
      end
    else
      self.errors << "output is required"
    end

    if watermark && !watermark.valid?
      self.errors << {:watermark => watermark.errors}
    end

    errors.empty?
  end

end
