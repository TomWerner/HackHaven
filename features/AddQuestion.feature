Feature: Users should be able to add questions

Scenario:  Add a question
  When I have added a question with title "Question 1" and description "This is a question."
  And I am on the Questions page
  Then I should see a question with title "Question 1" and description "This is a question."
