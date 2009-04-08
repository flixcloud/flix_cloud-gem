require 'builder'
require 'restclient'
require 'crack/xml'

module FlixCloud; end

require File.dirname(__FILE__) + '/flix_cloud/record'
require File.dirname(__FILE__) + '/flix_cloud/job'
require File.dirname(__FILE__) + '/flix_cloud/file_locations'
require File.dirname(__FILE__) + '/flix_cloud/file'
require File.dirname(__FILE__) + '/flix_cloud/input_file'
require File.dirname(__FILE__) + '/flix_cloud/output_file'
require File.dirname(__FILE__) + '/flix_cloud/watermark_file'
require File.dirname(__FILE__) + '/flix_cloud/parameters'
require File.dirname(__FILE__) + '/flix_cloud/response'
require File.dirname(__FILE__) + '/flix_cloud/extensions/hash'