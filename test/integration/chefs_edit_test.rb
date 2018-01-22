require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: "Test", email: "tester@test.com", password: "password", password_confirmation: "password")
    @chef2 = Chef.create!(chefname: "Test2", email: "tester2@test.com", password: "password", password_confirmation: "password")
     @admin_user = Chef.create!(chefname: "Test3", email: "tester3@test.com", password: "password", password_confirmation: "password", admin: true)
  end
  
 test "reject an invalid edit" do
   sign_in_as(@chef, "password")
   get edit_chef_path(@chef)
   assert_template 'chefs/edit'
   patch chef_path(@chef), params: { chef: { chefname: " ", email: "tester@test.com" } }
   assert_template 'chefs/edit'
   assert_select 'h4.panel-title'
   assert_select 'div.panel-body'
 end
 
 test "accept valid edit" do
   sign_in_as(@chef, "password")
   get edit_chef_path(@chef)
   assert_template 'chefs/edit'
   patch chef_path(@chef), params: { chef: { chefname: "Test1", email: "tester1@test.com" } }
   assert_redirected_to @chef
   assert_not flash.empty?
   @chef.reload
   assert_match 'Test1', @chef.chefname
   assert_match 'tester1@test.com', @chef.email
 end
 
 test "accept edit attempt by admin user" do
   sign_in_as(@admin_user, "password")
   get edit_chef_path(@chef)
   assert_template 'chefs/edit'
   patch chef_path(@chef), params: { chef: { chefname: "Test4", email: "tester4@test.com" } }
   assert_redirected_to @chef
   assert_not flash.empty?
   @chef.reload
   assert_match 'Test4', @chef.chefname
   assert_match 'tester4@test.com', @chef.email
 end
 
 test "redirect edit attempt by another non-admin user" do
   sign_in_as(@chef2, "password")
   updated_name = "joe"
   updated_email = "joe@example.com"
   patch chef_path(@chef), params: { chef: { chefname: updated_name, email: updated_email } }
   assert_redirected_to chefs_path
   assert_not flash.empty?
   @chef.reload
   assert_match 'Test', @chef.chefname
   assert_match 'tester@test.com', @chef.email
 end
 
end
