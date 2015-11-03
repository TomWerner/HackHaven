Feature: Users should be able to edit questions

Scenario:  Edit question
  When I have added a question with title "Question 1" and description "Question details."
  And I am on the Questions page
  Then I should see a question with title "Question 1" and description "Question details."
  
  When I have edited the "Question 1" question to have description "I edited this!"
  And I am on the Questions page
  Then I should see a question with title "Question 1" and description "I edited this!"
  
