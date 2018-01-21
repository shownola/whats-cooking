require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: "Test", email: "tester@test.com", password: "password", password_confirmation: "password")
  end
  
 test "reject an invalid edit" do
   get edit_chef_path(@chef)
   assert_template 'chefs/edit'
   patch chef_path(@chef), params: { chef: { chefname: " ", email: "tester@test.com" } }
   assert_template 'chefs/edit'
   assert_select 'h4.panel-title'
   assert_select 'div.panel-body'
 end
 
 test "accept valid edit" do
   get edit_chef_path(@chef)
   assert_template 'chefs/edit'
   patch chef_path(@chef), params: { chef: { chefname: "Test1", email: "tester1@test.com" } }
   assert_redirected_to @chef
   assert_not flash.empty?
   @chef.reload
   assert_match 'Test1', @chef.chefname
   assert_match 'tester1@test.com', @chef.email
 end
 
end
