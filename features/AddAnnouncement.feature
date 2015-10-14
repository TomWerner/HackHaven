Feature: Users should be able to add announcements

Scenario:  Add a announcement
  When I have added an announcement with title "Hawkeye Challenge" and content "The contest is on some date."
  And I am on the Announcements page  
  Then I should see an announcement with title "Hawkeye Challenge" and content "The contest is on some date."
