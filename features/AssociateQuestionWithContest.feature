Feature: Users should be able to associate a question with a contest

Scenario: Associate question with contest upon creating question
  Given a user has been logged in
  When I have added a contest with contest name "Cool Contest"
  When I have added a question with title "Question 1", description "This is a question.", and associated it with contest "Cool Contest"
  Then I should see a question with title "Question 1", description "This is a question.", and contest name "Cool Contest"