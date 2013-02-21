Feature: Game should end, once matched the code or failing


Background:
Given a user is logged in as "nobody"
And I started a new game

Scenario: Failure: Should not play more than 10 times
Given I should be on the Start Game page
When the following guesses were issued
     | code[0] | code[1] | code[2] | code[3] |
     | A       |  B      |  C      |  D      |
     | A       |  B      |  C      |  D      |
     | A       |  B      |  C      |  D      |
     | A       |  B      |  C      |  D      |
     | A       |  B      |  C      |  D      |
     | A       |  B      |  C      |  D      |
     | A       |  B      |  C      |  D      |
     | A       |  B      |  C      |  D      |
     | A       |  B      |  C      |  D      |
     | A       |  B      |  C      |  D      |
Then I should be on game over page
And I should see /Mala suerte!/


