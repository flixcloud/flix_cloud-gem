require 'test_helper'

class FlixCloud::ThumbnailFileTest < Test::Unit::TestCase

  should "assign to number_of_thumbnails and total_size" do
    thumbnail_file = FlixCloud::ThumbnailFile.new('number_of_thumbnails' => '123', 'total_size' => '321')
    assert_equal '123', thumbnail_file.number_of_thumbnails
    assert_equal '321', thumbnail_file.total_size
  end

end
