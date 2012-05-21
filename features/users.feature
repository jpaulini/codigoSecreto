Feature: User can login to start a new game

Scenario: User logs in

Given I am on the home page
When I follow "Login"
Then I should see the user input
And I should see the password input

