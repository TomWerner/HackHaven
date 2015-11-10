Feature: Allow HackHaven admin to add a contest
  
Scenario: Add a contest
  When I have added a contest with contest name "Cool Contest"
  And I am on the Upcoming Contests page
  Then I should see a contest list entry with contest name "Cool Contest"