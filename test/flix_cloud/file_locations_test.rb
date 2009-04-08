require 'test_helper'

class FlixCloud::FileLocationsTest < Test::Unit::TestCase

  context "When validationg a file locations object with no attributes set" do
    setup do
      @file_locations = FlixCloud::FileLocations.new
      @file_locations.valid?
    end

    should "require input" do
      assert_match /input is required/, @file_locations.errors.to_s
    end

    should "require output" do
      assert_match /output is required/, @file_locations.errors.to_s
    end
  end

  context "When validating a file locations object with input, output, and watermark objects that are invalid" do
    setup do
      @file_locations = FlixCloud::FileLocations.new(:input => {}, :output => {}, :watermark => {})
      @file_locations.valid?
    end

    should "inherit the input object's errors" do
      assert @file_locations.errors.any?{|error|
        error.is_a?(Hash) && error[:input] && !error[:input].empty?
      }, "Did not inherit input object's errors"
    end

    should "inherit the output object's errors" do
      assert @file_locations.errors.any?{|error|
        error.is_a?(Hash) && error[:output] && !error[:output].empty?
      }, "Did not inherit output object's errors"
    end

    should "inherit the watermark object's errors" do
      assert @file_locations.errors.any?{|error|
        error.is_a?(Hash) && error[:watermark] && !error[:watermark].empty?
      }, "Did not inherit watermark object's errors"
    end
  end

end
