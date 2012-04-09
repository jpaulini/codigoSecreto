Feature: User can play game

Scenario: Trying a first guess and winning

Given I am on the new Game page
When I fill in the following:
     | firstCell      | 'A' |
     | secondCell     | 'B' |
     | thirdCell      | 'C' |
     | fourthCell     | 'D' |
And I press "Guess!"
And the secret code is "ABCD"
Then I should be on the game over page
And I should see "Congratulations!"


