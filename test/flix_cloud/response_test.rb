require 'test_helper'

class FlixCloud::ResponseTest < Test::Unit::TestCase

  context "A response initialized with a rest client response" do
    setup do
      @rest_client_response = stub_rest_client_response(201, '<?xml version="1.0" encoding="UTF-8"?><something>wonderful</something>')
      @response = FlixCloud::Response.new(@rest_client_response)
    end

    should "store code in the code attribute" do
      assert_equal @rest_client_response.code, @response.code
    end

    should "store the body of the message in the body attribute" do
      assert_equal @rest_client_response.to_s, @response.body
    end

    should "store body converted to a hash in the body_as_hash attribute" do
      assert_equal Crack::XML.parse(@rest_client_response.to_s), @response.body_as_hash
    end

    should "initialize errors to an empty array" do
      assert_equal [], @response.errors
    end
  end

  context "A response initialized with a rest client response with a blank message body" do
    setup do
      @response = FlixCloud::Response.new(stub_rest_client_response(201, ''))
    end

    should "be successful" do
      assert @response.success?
    end

    should "have a blank array for the errors attribute" do
      assert_equal [], @response.errors
    end
  end

  context "A response initialized with a rest client response with a message body of errors" do
    setup do
      @response = FlixCloud::Response.new(stub_rest_client_response(200, '<?xml version="1.0" encoding="UTF-8"?><errors><error>There was an error doing something</error></errors>'))
    end

    should "not be successful" do
      assert !@response.success?
    end

    should "store the errors in the errors attribute" do
      assert_equal ['There was an error doing something'], @response.errors
    end
  end

end
