Feature: Users should be able to associate a question with a contest

Scenario: Associate question with contest upon creating question
  Given a user has been logged in
  When I have added a contest with contest name "Cool Contest"
  When I have added a question with title "Question 1", description "This is a question.", and associated it with contest "Cool Contest"
  Then I should see a question with title "Question 1", description "This is a question.", and contest name "Cool Contest"
  
Scenario: User can click contest name link on contests page to see all questions associated with that contest
  Given a user has been logged in
  When I have added a contest with contest name "Contest 1"
  And I have added a contest with contest name "Contest 2"
  And I have added a question with title "Question 1", description "This is a question.", and associated it with contest "Contest 1"
  And I have added a question with title "Question 2", description "This is another question.", and associated it with contest "Contest 2"
  And I click on contest "Contest 1" from the Upcoming Contests page
  Then I should see a question with title "Question 1" and description "This is a question."
  And I should not see a question with title "Question 2"