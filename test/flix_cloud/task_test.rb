require 'test_helper'

class FlixCloud::TaskTest < Test::Unit::TestCase

  should "split state into percent_complete and the state" do
    task = FlixCloud::Task.new('state' => ['awesome', '100.0'])
    assert_equal 'awesome', task.state
    assert_equal '100.0', task.percent_complete
  end

  should "assign to task_id" do
    task = FlixCloud::Task.new('task_id' => '100')
    assert_equal '100', task.task_id
  end

  %w{Failed failed Initialized initialized Processing processing Waiting waiting}.each do |text|
    should "be #{text.downcase} when the state text is #{text}" do
      task = FlixCloud::Task.new('state' => [text, '0.0'])
      assert task.send("#{text.downcase}?")
    end
  end

  # Successful is the only one whose method is different than the state
  %w{Success success}.each do |text|
    should "be successful when the state is #{text}" do
      task = FlixCloud::Task.new('state' => [text, '0.0'])
      assert task.successful?
    end
  end
end
