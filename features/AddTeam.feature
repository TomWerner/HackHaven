Feature: Allow HackHaven user to add a team during registration
  
Background: user has been added to HackHaven
  
  Given a user has been logged in
  Given a contest has been created with name "Fortran Contest"

Scenario: Add a team
  When I have added a registration for contest "Fortran Contest" with Create Own Team with name "Cool Cats"
  And I am on the Your Registrations page
  Then I should see a team list entry with name "Cool Cats"