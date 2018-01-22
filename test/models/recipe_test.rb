require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  
  def setup
    @chef = Chef.create!(chefname: "Apple Smith", email: "apple@example.com", password: "password", password_confirmation: "password")
    @recipe = @chef.recipes.build(name: "Sauteed Onion", description: "saute onions til translucent")
  end
  
  test "recipe without a chef should be invalid" do
    @recipe.chef_id = nil
    assert_not @recipe.valid?
  end
  
  test "recipe should be valid" do
    assert @recipe.valid?
  end
  
  test "name should be present" do
    @recipe.name = " "
    assert_not @recipe.valid?
  end
  
  test "description should be present" do
    @recipe.description = " "
    assert_not @recipe.valid?
  end
  
  test "description should not be less than 5 characters" do
    @recipe.description = "a" * 3
    assert_not @recipe.valid?
  end
  
  test "description should not be more than 1500 characters" do
    @recipe.description = "a" * 1501
    assert_not @recipe.valid?
  end
end