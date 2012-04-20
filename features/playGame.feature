Feature: User can play game

Background:
  Given I started a new game

Scenario: Trying a first guess and winning

Given I should be on the Start Game page
When I fill in the following:
     | code[0]   | 'A' |
     | code[1]   | 'B' |
     | code[2]   | 'C' |
     | code[3]   | 'D' |
And I press "Guess!"
Then I should be on playing page
And I should see the code table
And I should see the guesses table with "A B C D"



