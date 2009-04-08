require 'test_helper'

class FlixCloud::ParametersTest < Test::Unit::TestCase

  context "When validating a parameters object with no attributes set" do
    setup do
      @parameters = FlixCloud::Parameters.new
      @parameters.valid?
    end

    should "require user" do
      assert_match /user is required/, @parameters.errors.to_s
    end

    should "require password" do
      assert_match /password is required/, @parameters.errors.to_s
    end
  end

end
