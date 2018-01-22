require 'test_helper'

class ChefsIndexTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: "Test", email: "tester@test.com", password: "password", password_confirmation: "password")
    @chef2 = Chef.create!(chefname: "Test2", email: "tester2@test.com", password: "password", password_confirmation: "password")
    @admin_user = Chef.create!(chefname: "Test3", email: "tester3@test.com", password: "password", password_confirmation: "password", admin: true)
  end
  
  test 'should get chefs index page' do
    get chefs_path
    assert_response :success
  end
  
  test 'should get chefs listing' do
    get chefs_path
    assert_template 'chefs/index' 
    assert_select "a[href=?]", chef_path(@chef), text: @chef.chefname.titleize
    assert_match @chef.chefname, response.body
    assert_select 'ul.listing'
  end
  
  test "should delete chef" do
    sign_in_as(@admin_user, "password")
    get chefs_path
    assert_template 'chefs/index'
    assert_difference 'Chef.count', -1 do
      delete chef_path(@chef2)
    end
    assert_redirected_to chefs_path
    assert_not flash.empty?
  end
  
  
  
 
end
