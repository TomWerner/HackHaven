Feature: Users should be able to edit announcements

Scenario:  Edit announcement
  When I have added an announcement with title "Hawkeye Challenge" and content "The contest is on some date."
  And I am on the Announcements page
  Then I should see an announcement with title "Hawkeye Challenge" and content "The contest is on some date."
  
  When I have edited the "Hawkeye Challenge" announcement to have content "I edited this!"
  And I am on the Announcements page
  Then I should see an announcement with title "Hawkeye Challenge" and content "I edited this!"
  
