Feature: Allow HackHaven user to edit a registration
  
Background: user has been added to HackHaven
  
  Given a user has been logged in
    
  
Scenario: Edit a registration
  When I have added a registration with contest name "Contest 1 -- November 3rd"
  And I am on the Your Registrations page
  Then I should see a registration list entry with contest name "contest1"
  
  When I have edited a registration with contest name "contest1" to have contest name "Contest 2 -- November 5th"
  And I am on the Your Registrations page
  Then I should see a registration list entry with contest name "contest2"