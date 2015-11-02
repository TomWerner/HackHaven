Feature: Allow HackHaven user to add a registration
  
Background: user has been added to HackHaven
  
  Given a user has been logged in
    
  
Scenario: Add a registration
  When I have added a registration with contest name "Contest 1 -- November 3rd"
  And I am on the Your Registrations page
  Then I should see a registration list entry with contest name "contest1"