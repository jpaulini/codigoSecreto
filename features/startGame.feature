Feature: User can login to start a new game

Scenario: Accesing log in page

Given I am on the home page
When I follow "Login"
Then I should be on the log in page

Scenario: User logs in

Given a user is logged in as "nobody"
Then I should be on the Start Game page
And I should see "Logout"

Scenario: User logs out

Given a user is logged in as "nobody"
When I follow "Logout"
Then I should be on the home page

Scenario: User is redirected if not logged in
Given I am on the home page
When I go to the Start Game page
Then I should be on the log in page

Scenario: User is redirected if not logged in (II)
Given I am on the home page
When I go to the new Game page
Then I should be on the log in page

Scenario: User is redirected if not logged in (III)
Given I am on the home page
When I go to game over page
Then I should be on the log in page

Scenario: User should see a message if login fails
Given I am on the home page
When I put a wrong password
Then I should see "Login failed"
And I should be on the log in page
