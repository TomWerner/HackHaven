@AddAnnouncement
Feature: Users should be able to add announcements if they are an Admin, but not if they are a regular user

Scenario:  Add an announcement as an Admin
  When I am an Admin
  And I am on the Announcements page
  And I have added an announcement with title "Hawkeye Challenge" and content "The contest is on some date."
  
  Then I should see an announcement with title "Hawkeye Challenge" and content "The contest is on some date."
  
Scenario:  Add an announcement as regular user 
  When I try to add an announcement with title "Hawkeye Challenge" and content "The contest is on some date."
  And I am on the Announcements page
  And I am a regular user
  Then I should be rediredted to announcement index

Scenario:  Add an announcement when not signed in 
  When I try to add an announcement with title "Hawkeye Challenge" and content "The contest is on some date."
  And I am on the Announcements page
  And I am not signed in
  Then I should be rediredted to announcement index