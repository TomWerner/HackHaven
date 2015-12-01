Feature: Allow users to view a leaderboard for each contest

Background: user has been added to HackHaven
  
  Given an Admin has been logged in
  Given a contest has been created with name "Matlab Mayhem"
  Given a team with name "Cobra Coders" has been added for "Matlab Mayhem"

  
Scenario: View leaderboard
     Given I am on the Contest Page
     And I click on the "Leaderboard" link
     Then I should see a list entry with name "Cobra Coders"
     