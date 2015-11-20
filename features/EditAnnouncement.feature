Feature: Users should be able to edit announcements

Scenario:  Edit announcement
  When I am an Admin
  And I am on the Announcements page
  When I have added an announcement with title "Hawkeye Challenge" and content "The contest is on some date."
  Then I should see an announcement with title "Hawkeye Challenge" and content "The contest is on some date."
  
  When I have edited the "Hawkeye Challenge" announcement to have content "I edited this!"
  And I am on the Announcements page
  Then I should see an announcement with title "Hawkeye Challenge" and content "I edited this!"
  
Scenario: Edit announcement as a regular user  
  When I am a regular user
  And I am on the Announcements page
  And I try to add an announcement with title "Hawkeye Challenge" and content "The contest is on some date."
  Then I should be rediredted to announcement index
  
  When I try to edit the "Hawkeye Challenge" announcement to have content "I edited this!"
  And I am on the Announcements page
  Then I should be rediredted to announcement index
  
Scenario: Edit announcement as a non-member
  When I am not signed in
  And I am on the Announcements page
  And I try to add an announcement with title "Hawkeye Challenge" and content "The contest is on some date."
  Then I should be rediredted to announcement index
  
  When I try to edit the "Hawkeye Challenge" announcement to have content "I edited this!"
  And I am on the Announcements page
  Then I should be rediredted to announcement index
  

