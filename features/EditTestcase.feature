Feature: Users should be able to edit testcases for questions

Scenario:  Edit a testcase
  Given an Admin has been logged in
  When I have added a contest with contest name "Cool Contest"
  When I have added a question with title "Question 1" and description "This is a question."
  And I have added a testcase with input "4" and output "4 * 3 * 2 * 1 = 24" to question "Question 1"
  Then I should a testcase with input "4" and output "4 * 3 * 2 * 1 = 24" on the edit page of "Question 1"
  
  When I have edited the testcase with input "4" and output "4 * 3 * 2 * 1 = 24" to have output "44"
  Then I should a testcase with input "4" and output "44" on the edit page of "Question 1"