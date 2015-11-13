Feature: The pages of the app should be navigable using tabs

Scenario:  The tab of the current page should be highlighted
  Given I am on the Announcements page
  Then the "Announcements" tab should be highlighted
  And the "Questions" tab should not be highlighted
  
  Given a user has been logged in
  And I am on the Questions page
  Then the "Questions" tab should be highlighted
  And the "Announcements" tab should not be highlighted