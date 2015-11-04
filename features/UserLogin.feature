Feature: Users should be able to be able to sign in
  
Scenario: I should be able to sign in
  Given I have an account and am logged out
  And I click on the button that says "Sign up/Login"
  Then I should be able to log in
  And I should see "Login successful!"
  