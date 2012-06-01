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

