require 'test_helper'

class FlixCloud::BogusRecordTestClass < FlixCloud::Record
  record_column :bogus_record_test_child, 'BogusRecordTestChildClass'
end

class FlixCloud::BogusRecordTestChildClass < FlixCloud::Record
  attr_accessor :bogus_attribute
end

class FlixCloud::RecordTest < Test::Unit::TestCase

  context "With a record object initialized with no options" do
    setup do
      @record = FlixCloud::Record.new
    end

    should "intialize errors to an empty array" do
      assert_equal [], @record.errors
    end
  end

  context "With a record object initialized with options" do
    setup do
      @record = FlixCloud::Record.new(:errors => 'will be set, but', :bad_attributes => 'will not be set')
    end

    should "set the values of attributes that have attr_writers" do
      assert_equal 'will be set, but', @record.errors
    end
  end

  context "With a bogus class has a record column and has been initialized with attributes" do
    setup do
      @bogus_record = FlixCloud::BogusRecordTestClass.new(:bogus_record_test_child => {:bogus_attribute => 'bogus value'})
    end

    should "initialize both the parent class and the child class appropriately, assigning to the child attributes" do
      assert_not_nil @bogus_record
      assert @bogus_record.bogus_record_test_child.is_a?(FlixCloud::BogusRecordTestChildClass)
      assert_equal 'bogus value', @bogus_record.bogus_record_test_child.bogus_attribute
    end

    should "update the child attributes when assigning to the parent's child object attribute (confusing?)" do
      @bogus_record.bogus_record_test_child = {:bogus_attribute => 'a new bogus value'}
      assert_equal 'a new bogus value', @bogus_record.bogus_record_test_child.bogus_attribute
    end
  end

end
