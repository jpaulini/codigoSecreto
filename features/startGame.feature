Feature: User can start a new game

Scenario: Start a new game
Given I am on the home page
When I follow "Start a new game"
Then I should be on the new Game page

Given I am on the new Game page
Then I should see the code table
And I should see the guesses table


