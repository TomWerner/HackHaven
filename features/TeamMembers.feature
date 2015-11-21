Feature: Allow HackHaven users to be team captains and team members

Background: user has been added to HackHaven
  
  Given an Admin has been logged in
  Given a contest has been created with name "Semicolonless Contest"
  Given a team with name "The Ohms" has been added for "Semicolonless Contest"
  
Scenario: Become team captain
     When I am on my teams details page
     Then I should see a list entry with name "Team Captain"
     
Scenario: Become team member
     Given a different user has been logged in
     When I have added a registration for contest "Semicolonless Contest" with Select Team with name "The Ohms"
     And I am on my teams details page
     Then I should see a list entry with name "Team Member"
     Then I should see a list entry with name "Leave Team"
     