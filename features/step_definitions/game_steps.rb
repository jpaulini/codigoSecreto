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

Then /^I should see the guesses table with "(.*)"$/ do | guess |
  regexp = Regexp.new(guess.gsub(" ",".*"), Regexp::MULTILINE)

  if page.respond_to? :should
    page.should have_xpath('//table', {:id => "guesses-table", :text => regexp}), page.text
  else
    assert page.has_xpath?('//table', {:id => "guesses-table", :text => regexp}) , page.text
  end

end

Given /^I started a new game$/ do
    step "I go to the home page"
    step 'I follow "Start a new game"'
end

Given /^the following guesses were issued$/ do |table|
  table.hashes.each do |guess|
    select(guess["code[0]"], :from => "code[0]")
    select(guess["code[1]"], :from => "code[1]")
    select(guess["code[2]"], :from => "code[2]")
    select(guess["code[3]"], :from => "code[3]")
    step 'I press "Guess!"'
  end
end


