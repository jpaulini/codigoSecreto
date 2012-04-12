Feature: User can play game

Background:
  Given I started a new game

Scenario: Trying a first guess and winning

Given I should be on the Start Game page
When I fill in the following:
     | firstCell      | 'A' |
     | secondCell     | 'B' |
     | thirdCell      | 'C' |
     | fourthCell     | 'D' |
And I press "Guess!"
Then I should be on playing page
And I should see /A.*B.*C.*D.*[0-3]/


