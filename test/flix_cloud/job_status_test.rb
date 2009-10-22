require 'test_helper'

class FlixCloud::JobStatusTest < Test::Unit::TestCase

  context "When initializing with a string containing XML" do
    setup do
      @job_status = FlixCloud::JobStatus.new(%{<?xml version="1.0" encoding="UTF-8"?>
        <job>
          <id type="integer">1</id>
          <task-state>transcoding</task-state>
          <input-media-file-task>
              <task_id type="integer">162541</task_id>
              <state>success</state>
              <state type="float">100.0</state>
          </input-media-file-task>
          <transcoding-task>
              <task_id type="integer">162544</task_id>
              <state>processing</state>
              <state type="float">15.0</state>
          </transcoding-task>
          <output-media-file-task>
              <task_id type="integer">162545</task_id>
              <state>initialized</state>
              <state type="float">0.0</state>
          </output-media-file-task>
      </job>})
    end

    should "assign to all the attributes" do
      assert_not_nil @job_status.id
      assert_not_nil @job_status.task_state
      assert_not_nil @job_status.input_media_file_task
      assert_not_nil @job_status.input_media_file_task.task_id
      assert_not_nil @job_status.input_media_file_task.state
      assert_not_nil @job_status.input_media_file_task.percent_complete
      assert_not_nil @job_status.transcoding_task.task_id
      assert_not_nil @job_status.transcoding_task.state
      assert_not_nil @job_status.transcoding_task.percent_complete
      assert_not_nil @job_status.output_media_file_task.task_id
      assert_not_nil @job_status.output_media_file_task.state
      assert_not_nil @job_status.output_media_file_task.percent_complete
    end
  end

end