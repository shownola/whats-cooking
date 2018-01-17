require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: "Test", email: "tester@test.com")
    @recipe = Recipe.create!(name: "Sauteed Onions", description: "Sautee onions till clear", chef: @chef)
    @recipe2 = @chef.recipes.build(name: "Grilled Onions", description: "grill for 5 minutes")
    @recipe2.save
  end
  
  test "should get recipes index" do
    get recipes_path
    assert_response :success
  end
  
  test "should get recipes list" do
    get recipes_path
    assert_template 'recipes/index'
    assert_match @recipe.name, response.body
    assert_match @recipe2.name, response.body
  end
  
end
