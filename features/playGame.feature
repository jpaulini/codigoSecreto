Feature: User can play game

Background:
Given a user is logged in as "nobody"
And I started a new game

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


Scenario: Should keep the last guess issued
Given  I should be on the Start Game page
When the following guesses were issued
     | code[0] | code[1] | code[2] | code[3] |
     | D       |  B      |  C      |  A      |
Then the "code[0]" field should be set to "D"
And the "code[1]" field should be set to "B"
And the "code[2]" field should be set to "C"
And the "code[3]" field should be set to "A"

Scenario: I Should see the result of the guess matching the secret code
Given  I should be on the Start Game page
When the following guesses were issued
     | code[0] | code[1] | code[2] | code[3] |
     | D       |  B      |  C      |  A      |
And I should see the guesses table with "D B C A" and a number

