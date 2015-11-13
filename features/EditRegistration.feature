Feature: Allow HackHaven user to edit a registration
  
Background: user has been added to HackHaven
  
  Given a user has been logged in
  Given a contest has been created with name "Cool Contest"
  Given a contest has been created with name "Cooler Contest"
  
Scenario: Edit a registration
  When I have added a registration with contest name "Cool Contest"
  And I am on the Your Registrations page
  Then I should see a registration list entry with contest name "Cool Contest"
  
  When I have edited a registration with first name "Emily" to have first name "Not Emily"
  And I am on the Your Registrations page
  Then I should see a registration list entry with contest name "Cool Contest"
