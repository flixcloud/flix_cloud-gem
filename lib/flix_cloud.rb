require 'builder'
require 'restclient'
require 'crack/xml'

module FlixCloud; end

%w(record job file_locations file parameters response extensions/hash
   exceptions notification).each do |file|
  require File.dirname(__FILE__) + "/flix_cloud/#{file}"
end
