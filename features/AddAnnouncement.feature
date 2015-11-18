Feature: Users should be able to add announcements

Scenario:  Add a announcement
  When I have added an announcement with title "Hawkeye Challenge" and content "The contest is on some date."
  And I am on the Announcements page
  Then I should see an announcement with title "Hawkeye Challenge" and content "The contest is on some date."

Scenario:  Add a announcement (sad path)
  When I have added an announcement with title "" and content "valid"
  Then I should see "Title can't be blank"
  
  When I have added an announcement with title "title" and content ""
  Then I should see "Content can't be blank"