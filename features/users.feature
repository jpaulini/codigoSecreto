Feature: User can login to start a new game

Scenario: Accesing log in page

Given I am on the home page
When I follow "Login"
Then I should be on the log in page

Scenario: User logs in

Given a user is logged in as "nobody"
Then I should be on the Start Game page

