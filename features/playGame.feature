Feature: User can play game

Background:
  Given I started a new game

Scenario: Trying a first guess

Given I should be on the Start Game page
When the following guesses were issued
     | code[0] | code[1] | code[2] | code[3] |
     | A       | B       | C       | D       |
Then I should be on playing page
And I should see the code table
And I should see the guesses table with "A B C D"

Scenario: Trying more guesses

Given I should be on the Start Game page
When the following guesses were issued
     | code[0] | code[1] | code[2] | code[3] |
     | A       |  B      |  C      |  D      |
     | A       |  C      |  B      |  D      |

Then I should be on playing page
And I should see the code table
And I should see the guesses table with "A B C D"
And I should see the guesses table with "A C B D"

