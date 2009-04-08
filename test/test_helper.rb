require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'mocha'
require 'fakeweb'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'flix_cloud'

class Test::Unit::TestCase
  def stub_rest_client_response(code, message, body)
    stub(:code => code, :message => message, :to_s => body)
  end
end
