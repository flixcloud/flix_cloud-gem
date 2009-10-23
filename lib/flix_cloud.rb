require 'builder'
require 'http_client'
require 'crack/xml'

module FlixCloud; end

%w(record job file_locations file parameters response extensions/hash
   exceptions notification thumbnail_file job_status task cue_points cue_point
   cue_point_category parameter).each do |file|
  require File.dirname(__FILE__) + "/flix_cloud/#{file}"
end
