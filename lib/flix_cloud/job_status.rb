class FlixCloud::JobStatus < FlixCloud::Record

  attr_accessor :xml, :id, :task_state

  record_column :input_media_file_task, 'Task'
  record_column :output_media_file_task, 'Task'
  record_column :transcoding_task, 'Task'

  def initialize(attrs={})
    if attrs.is_a?(String)
      self.xml = attrs
      attrs = Crack::XML.parse(attrs)
    end

    attrs = attrs['job'] if attrs['job']

    super(attrs)
  end

  def cancelled_job?
    task_state == 'cancelled_job'
  end

  def downloading_input_files?
    task_state == 'downloading_input_files'
  end

  def failed_job?
    task_state == 'failed_job'
  end

  def initialized_job?
    task_state == 'initialized_job'
  end

  def notifying?
    task_state == 'notifying'
  end

  def successful_job?
    task_state == 'successful_job'
  end

  def transcoding?
    task_state == 'transcoding'
  end

  def uploading_output_files?
    task_state == 'uploading_output_files'
  end

  def waiting_to_download_input_files?
    task_state == 'waiting_to_download_input_files'
  end

  def waiting_to_notify?
    task_state == 'waiting_to_notify'
  end

  def waiting_to_transcode?
    task_state == 'waiting_to_transcode'
  end

  def waiting_to_upload_output_files?
    task_state == 'waiting_to_upload_output_files'
  end

end
