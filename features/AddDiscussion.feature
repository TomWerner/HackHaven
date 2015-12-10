Feature: Allow HackHaven user to add a discussion

Background:
  Given I am an Admin
  Given a contest has been created with name "Cool Contest"
  Given I have added a question with title "Question 1" and description "This is a question."
    
  
Scenario: Add a discussion
  When I have added a discussion for question "Question 1" with title "Discussion 1"
  When I view the discussions for question "Question 1"
  Then I should see a discussion with the title "Discussion 1"