Given /^a user is logged in as "(.*)"$/ do |login|
  @current_user = User.create!(
    :name => 'nobody',
    :password => 'not4long',
    :password_confirmation => 'not4long',
    :is_admin => false
  )
  
  visit '/login'
  fill_in("name", :with => @current_user.name)
  fill_in('password', :with => 'not4long')
  click_button("Login")
  
end

When /^I put a wrong password$/ do
  @current_user = User.create!(
    :name => 'nobody',
    :password => 'not4long',
    :password_confirmation => 'not4long',
    :is_admin => false
  )
  visit '/login'
  fill_in("name", :with => @current_user.name)
  fill_in('password', :with => 'wrongpasword')
  click_button("Login")
end

Then /^I should see a notice saying "(.*?)"$/ do |arg1|
	page.should have_content(:notice)
	
end

