class FlixCloud::Notification < FlixCloud::Record
  attr_accessor :xml, :id, :finished_job_at, :initialized_job_at,
                :recipe_name, :recipe_id, :state, :error_message

  record_column :input_media_file, 'File'
  record_column :output_media_file, 'File'
  record_column :watermark_file, 'File'

  def initialize(attrs={})
    if attrs.is_a?(String)
      self.xml = attrs
      attrs = Crack::XML.parse(attrs)
    end

    attrs = attrs['job'] if attrs['job']

    super(attrs)
  end

  def successful?
    state == 'successful_job'
  end

  def failed?
    state == 'failed_job'
  end

  def cancelled?
    state == 'cancelled_job'
  end

end
