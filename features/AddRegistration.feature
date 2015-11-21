Feature: Allow HackHaven user to add a registration
  
Background: user has been added to HackHaven
  Given I am an Admin
  Given a contest has been created with name "Cool Contest"
    
  
Scenario: Add a registration
  When I have added a registration with contest name "Cool Contest"
  And I am on the Your Registrations page
  Then I should see a registration list entry with contest name "Cool Contest"