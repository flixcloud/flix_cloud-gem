require 'test_helper'

class FlixCloud::JobTest < Test::Unit::TestCase

  context "When validating a job object with no attributes set" do
    setup do
      @job = FlixCloud::Job.new
      @job.valid?
    end

    should "require an api key" do
      assert_match /api_key is required/, @job.errors.to_s
    end

    should "require file_locations" do
      assert_match /file_locations is required/, @job.errors.to_s
    end

    should "require recipe_id or recipe_name" do
      assert_match /recipe_id or recipe_name is required/, @job.errors.to_s
    end
  end


  context "When validating a job object with both recipe_id and recipe_name are set" do
    setup do
      @job = FlixCloud::Job.new(:recipe_name => 'recipe-name', :recipe_id => 1)
      @job.valid?
    end

    should "require that both recipe_id and recipe_name cannot be used" do
      assert_match /recipe_id and recipe_name cannot both be used/, @job.errors.to_s
    end
  end


  context "When validating a job object with a file_locations object that is invalid" do
    setup do
      @job = FlixCloud::Job.new(:file_locations => {})
      @job.valid?
    end

    should "inherit the file_locations object's errors" do
      assert @job.errors.any?{|error|
        error.is_a?(Hash) && error[:file_locations] && !error[:file_locations].empty?
      }, "Did not inherit file_locations object's errors"
    end
  end


  context "When validating a job object with errors on the deepest nested object possible (parameters)" do
    setup do
      @job = FlixCloud::Job.new(:file_locations => {:input => {:parameters => {}}})
      @job.valid?
    end

    should "inherit the errors of the deepest nested object possible (parameters)" do
      first_level_errors = @job.errors.find{|error| error.is_a?(Hash) && error[:file_locations] && !error[:file_locations].empty? }[:file_locations]
      second_level_errors = first_level_errors.find{|error| error.is_a?(Hash) && error[:input] && !error[:input].empty? }[:input]

      assert second_level_errors.any?{|error|
        error.is_a?(Hash) && error[:parameters] && !error[:parameters].empty?
      }, "Did not inherit the errors of the deepest nested object possible (parameters)"
    end
  end


  context "A job with no attributes set" do
    setup do
      @job = FlixCloud::Job.new
    end

    should "serialize to xml, excluding everything but api-key and recipe-id" do
      assert_equal %{<?xml version="1.0" encoding="UTF-8"?><api-request><api-key></api-key><recipe-id></recipe-id></api-request>}, @job.to_xml
    end
  end


  context "A job with file_locations set" do
    setup do
      @job = FlixCloud::Job.new(:file_locations => {})
    end

    should "serialize to xml, excluding everything but api-key, recipe-id, and file-locations" do
      assert_equal %{<?xml version="1.0" encoding="UTF-8"?><api-request><api-key></api-key><recipe-id></recipe-id><file-locations></file-locations></api-request>}, @job.to_xml
    end
  end


  context "A job with file_locations and input set" do
    setup do
      @job = FlixCloud::Job.new(:file_locations => {:input => {}})
    end

    should "serialize to xml, excluding everything but api-key, recipe-id, file-locations, and input" do
      assert_equal %{<?xml version="1.0" encoding="UTF-8"?><api-request><api-key></api-key><recipe-id></recipe-id><file-locations><input><url></url></input></file-locations></api-request>}, @job.to_xml
    end
  end


  context "A job with file-locations, input, and input-parameters set" do
    setup do
      @job = FlixCloud::Job.new(:file_locations => {:input => {:parameters => {}}})
    end

    should "serialize to xml, excluding everything but api-key, recipe-id, file-locations, input, and input-parameters" do
      assert_equal %{<?xml version="1.0" encoding="UTF-8"?><api-request><api-key></api-key><recipe-id></recipe-id><file-locations><input><url></url><parameters><user></user><password></password></parameters></input></file-locations></api-request>}, @job.to_xml
    end
  end


  context "A job with recipe_id set" do
    setup do
      @job = FlixCloud::Job.new(:recipe_id => 1)
    end

    should "serialize to xml and include the recipe_id, not the recipe_name" do
      assert_equal %{<?xml version="1.0" encoding="UTF-8"?><api-request><api-key></api-key><recipe-id>1</recipe-id></api-request>}, @job.to_xml
    end
  end


  context "A job with a recipe_name set" do
    setup do
      @job = FlixCloud::Job.new(:recipe_name => 'recipe-name')
    end

    should "serialize to xml and include the recipe_name, not the recipe_id" do
      assert_equal %{<?xml version="1.0" encoding="UTF-8"?><api-request><api-key></api-key><recipe-name>recipe-name</recipe-name></api-request>}, @job.to_xml
    end
  end


  context "A job with all attributes set" do
    setup do
      @job = FlixCloud::Job.new(:recipe_id => 1,
                                :api_key => 'this_is_an_api_key',
                                :file_locations => { :input => { :url => 'http://flixcloud.com/somefile.mp4',
                                                                 :parameters => { :user => 'user',
                                                                                  :password => 'password'}},
                                                     :output => { :url => 'ftp://flixcloud.com/somefile.mp4',
                                                                  :parameters => { :user => 'user',
                                                                                   :password => 'password'}},
                                                     :watermark => { :url => 'http://flixcloud.com/somefile.mp4',
                                                                     :parameters => { :user => 'user',
                                                                                      :password => 'password'}}})
    end

    should "serialize everything to xml" do
      assert_equal %{<?xml version="1.0" encoding="UTF-8"?><api-request><api-key>this_is_an_api_key</api-key><recipe-id>1</recipe-id><file-locations><input><url>http://flixcloud.com/somefile.mp4</url><parameters><user>user</user><password>password</password></parameters></input><output><url>ftp://flixcloud.com/somefile.mp4</url><parameters><user>user</user><password>password</password></parameters></output><watermark><url>http://flixcloud.com/somefile.mp4</url><parameters><user>user</user><password>password</password></parameters></watermark></file-locations></api-request>}, @job.to_xml
    end
  end


  context "An invalid job when attempting to save" do
    setup do
      @job = FlixCloud::Job.new
      @result = @job.save
    end

    should "return false" do
      assert_equal false, @result
    end

    should "set errors on the job" do
      assert @job.errors.is_a?(Array)
      assert_not_equal [], @job.errors
    end
  end

  context "A valid job when attempting to save" do
    setup do
      FakeWeb.allow_net_connect = false
      @job = FlixCloud::Job.new(:recipe_id => 1,
                                :api_key => 'this_is_an_api_key',
                                :file_locations => { :input => { :url => 'http://flixcloud.com/somefile.mp4',
                                                                 :parameters => { :user => 'user',
                                                                                  :password => 'password'}},
                                                     :output => { :url => 'ftp://flixcloud.com/somefile.mp4',
                                                                  :parameters => { :user => 'user',
                                                                                   :password => 'password'}},
                                                     :watermark => { :url => 'http://flixcloud.com/somefile.mp4',
                                                                     :parameters => { :user => 'user',
                                                                                      :password => 'password'}}})
    end

    teardown do
      FakeWeb.clean_registry
      FakeWeb.allow_net_connect = true
    end

    context "when saving with malformed xml (should really never happen, but what if?)" do
      setup do
        FakeWeb.register_uri(:post, 'https://flixcloud.com/jobs', :string => %{<?xml version="1.0" encoding="UTF-8"?><errors><error>Malformed XML</error></errors>},
                                                                  :status => ['400', 'Bad Request'])
      end

      should "not be successful" do
        assert !@job.save
      end

      should "have a 400 response code" do
        @job.save
        assert_equal 400, @job.response.code
      end

      should "store the errors on the job" do
        @job.save
        assert_equal ['Malformed XML'], @job.errors
      end
    end


    context "when saving with an invalid schema (should really never happen, but what if?)" do
      setup do
        FakeWeb.register_uri(:post, 'https://flixcloud.com/jobs', :string => %{<?xml version="1.0" encoding="UTF-8"?><errors><error>Schema is invalid</error></errors>},
                                                                  :status => ['400', 'Bad Request'])
      end

      should "not be successful" do
        assert !@job.save
      end

      should "have a 400 response code" do
        @job.save
        assert_equal 400, @job.response.code
      end

      should "store the errors on the job" do
        @job.save
        assert_equal ['Schema is invalid'], @job.errors
      end
    end


    context "when saving and the api-key is not valid" do
      setup do
        FakeWeb.register_uri(:post, 'https://flixcloud.com/jobs', :status => ['401', 'Unauthorized'])
      end

      should "not be successful" do
        assert !@job.save
      end

      should "have a 401 response code" do
        @job.save
        assert_equal 401, @job.response.code
      end
    end


    context "when saving and there are errors on the job so it can't be saved" do
      setup do
        FakeWeb.register_uri(:post, 'https://flixcloud.com/jobs', :string => %{<?xml version="1.0" encoding="UTF-8"?><errors><error>You are missing this thing and that thing</error></errors>},
                                                                  :status => ['200', 'OK'])
      end

      should "return false" do
        assert_equal false, @job.save
      end

      should "set the jobs errors to the response body's errors" do
        @job.save
        assert_equal ["You are missing this thing and that thing"], @job.errors
      end
    end

    context "when saving was successful" do
      setup do
        FakeWeb.register_uri(:post, 'https://flixcloud.com/jobs', :string => %{<?xml version="1.0" encoding="UTF-8"?><job><id type="integer">1</id><initialized-job-at type="datetime">2009-04-07T23:15:33+02:00</initialized-job-at></job>},
                                                                  :status => ['201', 'Created'])
      end

      should "return true" do
        assert_equal true, @job.save
      end

      should "save the id from the response on the job" do
        @job.save
        assert_equal 1, @job.id
      end

      should "save the initialization time from the response on the job" do
        @job.save
        assert_equal "Tue Apr 07 21:15:33 UTC 2009", @job.initialized_at.to_s
      end
    end
  end

  context "When using shortcut attributes for job initialization" do
    setup do
      @job = FlixCloud::Job.new(:api_key => 'your-api-key',
                                :recipe_id => 2,
                                :input_url          => 'your-input-url',
                                :input_user         => 'your-input-user',
                                :input_password     => 'your-input-password',
                                :output_url         => 'your-output-url',
                                :output_user        => 'your-output-user',
                                :output_password    => 'your-output-password',
                                :watermark_url      => 'your-watermark-url',
                                :watermark_user     => 'your-watermark-user',
                                :watermark_password => 'your-watermark-password')
    end

    should "set the urls" do
      assert_equal 'your-input-url', @job.file_locations.input.url
      assert_equal 'your-output-url', @job.file_locations.output.url
      assert_equal 'your-watermark-url', @job.file_locations.watermark.url
    end

    should "set the users" do
      assert_equal 'your-input-user', @job.file_locations.input.parameters.user
      assert_equal 'your-output-user', @job.file_locations.output.parameters.user
      assert_equal 'your-watermark-user', @job.file_locations.watermark.parameters.user
    end

    should "set the passwords" do
      assert_equal 'your-input-password', @job.file_locations.input.parameters.password
      assert_equal 'your-output-password', @job.file_locations.output.parameters.password
      assert_equal 'your-watermark-password', @job.file_locations.watermark.parameters.password
    end
  end


  context "When calling save! on an invalid job" do
    setup do
      @job = FlixCloud::Job.new
    end

    should "raise a FlixCloud::SaveError" do
      assert_raises FlixCloud::SaveError do
        @job.save!
      end
    end
  end


  context "When calling save! on a valid job" do
    setup do
      FakeWeb.allow_net_connect = false
      FakeWeb.register_uri(:post, 'https://flixcloud.com/jobs', :string => %{<?xml version="1.0" encoding="UTF-8"?><job><id type="integer">1</id><initialized-job-at type="datetime">2009-04-07T23:15:33+02:00</initialized-job-at></job>},
                                                                :status => ['201', 'Created'])
      @job = FlixCloud::Job.new(:api_key => 'your-api-key',
                                :recipe_id => 2,
                                :input_url          => 'your-input-url',
                                :input_user         => 'your-input-user',
                                :input_password     => 'your-input-password',
                                :output_url         => 'your-output-url',
                                :output_user        => 'your-output-user',
                                :output_password    => 'your-output-password',
                                :watermark_url      => 'your-watermark-url',
                                :watermark_user     => 'your-watermark-user',
                                :watermark_password => 'your-watermark-password')
    end

    teardown do
      FakeWeb.clean_registry
      FakeWeb.allow_net_connect = true
    end

    should "return true" do
      assert_equal true, @job.save!
    end
  end

  context "When creating an invalid job" do
    setup do
      @job = FlixCloud::Job.create
    end

    should "return a FlixCloud::Job" do
      assert @job.is_a?(FlixCloud::Job)
    end

    should "have errors on the job" do
      assert !@job.errors.empty?
    end
  end

  context "When creating a valid job" do
    setup do
      FakeWeb.allow_net_connect = false
      FakeWeb.register_uri(:post, 'https://flixcloud.com/jobs', :string => %{<?xml version="1.0" encoding="UTF-8"?><job><id type="integer">1</id><initialized-job-at type="datetime">2009-04-07T23:15:33+02:00</initialized-job-at></job>},
                                                                :status => ['201', 'Created'])
      @job = FlixCloud::Job.create(:api_key => 'your-api-key',
                                   :recipe_id => 2,
                                   :input_url          => 'your-input-url',
                                   :input_user         => 'your-input-user',
                                   :input_password     => 'your-input-password',
                                   :output_url         => 'your-output-url',
                                   :output_user        => 'your-output-user',
                                   :output_password    => 'your-output-password',
                                   :watermark_url      => 'your-watermark-url',
                                   :watermark_user     => 'your-watermark-user',
                                   :watermark_password => 'your-watermark-password')
    end

    teardown do
      FakeWeb.clean_registry
      FakeWeb.allow_net_connect = true
    end

    should "return a FlixCloud::Job" do
      assert @job.is_a?(FlixCloud::Job)
    end

    should "not have errors on the job" do
      assert @job.errors.empty?
    end

    should "have an id set" do
      assert_not_nil @job.id
    end
  end

  context "When using create! to create an invalid job" do
    should "raise a FlixCloud::CreationError exception" do
      assert_raises FlixCloud::CreateError do
        @job = FlixCloud::Job.create!
      end
    end
  end

  context "When using create! to create a valid job" do
    setup do
      FakeWeb.allow_net_connect = false
      FakeWeb.register_uri(:post, 'https://flixcloud.com/jobs', :string => %{<?xml version="1.0" encoding="UTF-8"?><job><id type="integer">1</id><initialized-job-at type="datetime">2009-04-07T23:15:33+02:00</initialized-job-at></job>},
                                                                :status => ['201', 'Created'])
      @job = FlixCloud::Job.create!(:api_key => 'your-api-key',
                                    :recipe_id => 2,
                                    :input_url          => 'your-input-url',
                                    :input_user         => 'your-input-user',
                                    :input_password     => 'your-input-password',
                                    :output_url         => 'your-output-url',
                                    :output_user        => 'your-output-user',
                                    :output_password    => 'your-output-password',
                                    :watermark_url      => 'your-watermark-url',
                                    :watermark_user     => 'your-watermark-user',
                                    :watermark_password => 'your-watermark-password')
    end

    teardown do
      FakeWeb.clean_registry
      FakeWeb.allow_net_connect = true
    end

    should "return a job" do
      assert @job.is_a?(FlixCloud::Job)
    end

    should "return a job with an id" do
      assert_not_nil @job.id
    end
  end
end
