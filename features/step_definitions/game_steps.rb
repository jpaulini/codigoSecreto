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


When /^the secret code is "([^"]*)"$/ do |code|
  pending # express the regexp above with the code you wish you had
end

