require 'test_helper'

class FlixCloud::NotificationTest < Test::Unit::TestCase

  context "When initializing with a string containing xml" do
    setup do
      @notification = FlixCloud::Notification.new(
        %{<?xml version="1.0" encoding="UTF-8"?>
          <job>
            <finished-job-at type="datetime">2009-04-10T20:13:02Z</finished-job-at>
            <id type="integer">1</id>
            <initialized-job-at type="datetime">2009-04-10T20:05:28Z</initialized-job-at>
            <recipe-name>testerrrr</recipe-name>
            <recipe-id type="integer">172</recipe-id>
            <state>successful_job</state>
            <error-message>error message</error-message>
            <input-media-file>
              <url>s3://flixcloud-test/small.mov</url>
              <width>1280</width>
              <height>720</height>
              <size>1732204</size>
              <duration>900</duration>
            </input-media-file>
            <output-media-file>
              <url>s3://flixcloud-test/fsdfasdf.mov</url>
              <width>320</width>
              <height>176</height>
              <size>44126</size>
              <duration>700</duration>
            </output-media-file>
            <watermark-file>
              <url>http://dl.getdropbox.com/u/378873/zencoder_test.mov</url>
              <size>1234</size>
            </watermark-file>
          </job>})
    end

    should "assign to all the attributes" do
      assert_not_nil @notification.xml
      assert_not_nil @notification.id
      assert_not_nil @notification.finished_job_at
      assert_not_nil @notification.initialized_job_at
      assert_not_nil @notification.recipe_name
      assert_not_nil @notification.recipe_id
      assert_not_nil @notification.state
      assert_not_nil @notification.error_message
    end
  end


  context "When initializing with a hash" do
    setup do
      @notification = FlixCloud::Notification.new({"job" => {"initialized_job_at" => "something",
                                                             "input_media_file" => {"size" => "1732204",
                                                                                    "url" => "s3://flixcloud-test/small.mov",
                                                                                    "height" => "720",
                                                                                    "duration" => "900",
                                                                                    "width" => "1280"},
                                                             "watermark_file" => {"size" => "1234",
                                                                                  "url" => "http://dl.getdropbox.com/u/378873/zencoder_test.mov"},
                                                             "output_media_file" => {"size" => "44126",
                                                                                     "url" => "s3://flixcloud-test/fsdfasdf.mov",
                                                                                     "height" => "176",
                                                                                     "duration" => "700",
                                                                                     "width" => "320"},
                                                             "id" => 1,
                                                             "recipe_id" => 172,
                                                             "error_message" => 'error message',
                                                             "finished_job_at" => 'something else',
                                                             "recipe_name"=>"testerrrr",
                                                             "state"=>"successful_job"}})
    end

    should "assign to all the attributes except the xml attribute" do
      assert_nil @notification.xml
      assert_not_nil @notification.id
      assert_not_nil @notification.finished_job_at
      assert_not_nil @notification.initialized_job_at
      assert_not_nil @notification.recipe_name
      assert_not_nil @notification.recipe_id
      assert_not_nil @notification.state
      assert_not_nil @notification.error_message
    end
  end


  context "When initializing with a hash and the parameters are not nested beneath 'job'" do
    setup do
      @notification = FlixCloud::Notification.new({"initialized_job_at" => "something",
                                                   "input_media_file" => {"size" => "1732204",
                                                                          "url" => "s3://flixcloud-test/small.mov",
                                                                          "height" => "720",
                                                                          "duration" => "900",
                                                                          "width" => "1280"},
                                                   "watermark_file" => {"size" => "1234",
                                                                        "url" => "http://dl.getdropbox.com/u/378873/zencoder_test.mov"},
                                                   "output_media_file" => {"size" => "44126",
                                                                           "url" => "s3://flixcloud-test/fsdfasdf.mov",
                                                                           "height" => "176",
                                                                           "duration" => "700",
                                                                           "width" => "320"},
                                                   "id" => 1,
                                                   "recipe_id" => 172,
                                                   "error_message" => 'error message',
                                                   "finished_job_at" => 'something else',
                                                   "recipe_name"=>"testerrrr",
                                                   "state"=>"successful_job"})
    end

    should "assign to all the attributes except the xml attribute" do
      assert_nil @notification.xml
      assert_not_nil @notification.id
      assert_not_nil @notification.finished_job_at
      assert_not_nil @notification.initialized_job_at
      assert_not_nil @notification.recipe_name
      assert_not_nil @notification.recipe_id
      assert_not_nil @notification.state
      assert_not_nil @notification.error_message
    end
  end

end