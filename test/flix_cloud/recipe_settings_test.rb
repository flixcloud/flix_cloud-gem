require 'test_helper'

class FlixCloud::RecipeSettingsTest < Test::Unit::TestCase

  FlixCloud::RecipeSettings.recipe_attributes.each do |attribute|
    should "assign to #{attribute} attribute" do
      recipe_settings = FlixCloud::RecipeSettings.new(attribute => 'foo')
      assert_equal 'foo', recipe_settings.send(attribute)
    end
  end

end
