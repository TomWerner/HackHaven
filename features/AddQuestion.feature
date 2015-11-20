Feature: Users should be able to add questions

Scenario:  Add a question
  Given a user has been logged in
  When I have added a contest with contest name "Cool Contest"
  When I have added a question with title "Question 1" and description "This is a question."
  And I am on the Questions page
  Then I should see a question with title "Question 1" and description "This is a question."
  
Scenario:  Add a question (sad path)
  Given a user has been logged in
  When I have added a question with title "" and description "valid"
  Then I should see "Title can't be blank"
  
  When I have added a question with title "title" and description ""
  Then I should see "Description can't be blank"
  
