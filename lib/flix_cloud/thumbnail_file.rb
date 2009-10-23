class FlixCloud::ThumbnailFile < FlixCloud::File

  attr_accessor :number_of_thumbnails, :total_size, :prefix

  def valid?
    super

    unless prefix
      self.errors << "prefix is required"
    end

    errors.empty?
  end

end
