FlixCloud Gem
=============

The gem for interacting with the API on [FlixCloud](http://flixcloud.com).

See [http://flixcloud.com/api](http://flixcloud.com/api) for more details on the API.

Examples
========

Rails
-----

If you're using rails, you can add the following to your environment.rb:

    config.gem 'flixcloud-flix_cloud-gem', :lib => 'flix_cloud', :source => 'http://gems.github.com'
    config.gem 'sevenwire-http_client', :lib => 'http_client', :source => 'http://gems.github.com'
    config.gem 'crack'

Then you can run:

    rake gems:install
    rake gems:unpack

Ruby or Other Frameworks
------------------------

Install the gems (sudo may be necessary):

    gem install flixcloud-flix_cloud-gem --source http://gems.github.com
    gem install sevenwire-http_client --source http://gems.github.com
    gem install crack

Then in your code you can just require the FlixCloud gem:

    require 'rubygems'
    require 'flix_cloud'

Creating Jobs
-------------

You can create jobs using the Job class:

    job = FlixCloud::Job.new(:api_key => 'your-api-key-here',
                             :recipe_id => 1,
                             :input_url => 'http://url/to/your/input/file',
                             :output_url => 'ftp://url/to/your/output/file',
                             :output_user => 'username-for-ftp-here',
                             :output_password => 'password-for-ftp-here',
                             :watermark_url => 's3://url/to/your/watermark/file',
                             :thumbnails_url => 's3://url/to/your/thumbnail-out-file')
    job.valid?         # true or false
    job.save           # true or false
    job.id             # returns the id of the saved job, or nil if it failed to save
    job.initialized_at # returns the time the job was created, or nil if it failed to save

Job is modeled after ActiveRecord, so create, create!, save, save!, etc all work.

See [this](http://flixcloud.com/api#sending_jobs_to_flix_cloud) for more information.

Job Notifications
-----------------

When you receive a notification from FlixCloud, you can process it using the Notification class:

    job = FlixCloud::Notification.new(notification_xml_or_hash)
    job.successful?                # true if the state is 'successful_job', false if not
    job.failed?                    # true if the state is 'failed_job', false if not
    job.cancelled?                 # true if the state is 'cancelled_job', false if not
    job.id                         # the id of the job that finished
    job.finished_job_at            # the time the job finished at
    job.initialized_job_at         # the time the job was created at
    job.recipe_name                # the name of the recipe used to process the job
    job.recipe_id                  # the id of the recipe used to process the job
    job.state                      # the state of the finished job. 'successful_job', 'failed_job', or 'cancelled_job'
    job.error_message              # the error message given for the job if it failed to process
    job.input_media_file.url       # url of the input file
    job.input_media_file.width     # width of the input file in pixels
    job.input_media_file.height    # height of the input file in pixels
    job.input_media_file.size      # size of the input file in bytes
    job.input_media_file.duration  # duration of the input file in milliseconds
    job.input_media_file.cost      # cost of the input file in millicents (1/1000th of a cent)
    job.output_media_file.url      # url of the output file
    job.output_media_file.width    # width of the output file in pixels
    job.output_media_file.height   # height of the output file in pixels
    job.output_media_file.size     # size of the output file in bytes
    job.output_media_file.duration # duration of the output file in milliseconds
    job.output_media_file.cost     # cost of the output file in millicents (1/1000th of a cent)
    job.watermark_file.url         # url of the watermark file
    job.watermark_file.size        # size of the watermark file in bytes
    job.watermark_file.cost        # cost of the watermark file in millicents (1/1000th of a cent)

See [this](http://flixcloud.com/api#job_notifications) for more information.

Note
----

Creating jobs sends HTTP requests to FlixCloud, which may take some time. It's
best to do this asynchronously in your application.


COPYRIGHT
=========

Copyright (c) 2009 Zencoder. See LICENSE for details.
