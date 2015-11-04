Feature: Users should be able to sign up

Scenario: User sign up
  Given I clicked on a link to sign up
  Then I should be able to fill out the form with the name "Test User" to sign up
  And I should see "Welcome Test User. Your account has been created."