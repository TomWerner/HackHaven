Feature: Users should be able to add testcases to questions

Scenario:  Add a testcase
  When I am an Admin
  When I have added a contest with contest name "Cool Contest"
  When I have added a question with title "Question 1" and description "This is a question."
  And I have added a testcase with input "4" and output "4 * 3 * 2 * 1 = 24" to question "Question 1"
  Then I should a testcase with input "4" and output "4 * 3 * 2 * 1 = 24" on the edit page of "Question 1"
