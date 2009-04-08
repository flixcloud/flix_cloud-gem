require 'test_helper'

class FlixCloud::FileTest < Test::Unit::TestCase

  context "When validating a file object with no attributes set" do
    setup do
      @file = FlixCloud::File.new
      @file.valid?
    end

    should "require url" do
      assert_match /url is required/, @file.errors.to_s
    end
  end

  context "When validating a file object with a parameters object that is invalid" do
    setup do
      @file = FlixCloud::File.new(:parameters => {})
      @file.valid?
    end

    should "inherit the parameters object's errors" do
      assert @file.errors.any?{|error|
        error.is_a?(Hash) && error[:parameters] && !error[:parameters].empty?
      }, "Did not inherit parameters object's errors"
    end
  end

end
