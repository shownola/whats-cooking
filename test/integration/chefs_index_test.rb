require 'test_helper'

class ChefsIndexTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: "Test", email: "tester@test.com", password: "password", password_confirmation: "password")
  end
  
  test 'should get chefs index page' do
    get chefs_path
    assert_response :success
  end
  
  test 'should get chefs listing' do
    get chefs_path
    assert_template 'chefs/index'
    assert_match @chef.chefname, response.body
    assert_select 'ul.listing'
    
  end
end
