Then /^I should see the code table$/ do
  if page.respond_to? :should
    page.should have_xpath('//table',:id => "code-table")
  else
    assert page.has_xpath?('//table',:id => "code-table")
  end
end


Then /^I should see the guesses table$/ do
  if page.respond_to? :should
    page.should have_xpath('//table',:id => "guesses-table")
  else
    assert page.has_xpath?('//table',:id => "guesses-table")
  end

end

Given /^I started a new game$/ do
    step "I go to the home page"
    step 'I follow "Start a new game"'
end

