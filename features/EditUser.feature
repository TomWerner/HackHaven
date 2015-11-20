Feature: Admins should be able to take away or grant admin status to other users
  Scenario: Edit a user's admin status
    When I am an admin
    And there is a user with the name "Dave", the email "dave@gmail.com", and he is "Admin"
    And I am on the user page
    Then I should view the name "Dave", the email "dave@gmail.com", and he is "Admin"
    
    When I have edited "Dave" with email "dave@gmail.com" to be a "Member"
    And I am on the user page
    Then I should view the name "Dave", the email "dave@gmail.com", and he is "Member"
    
  Scenario: Attempt to edit a user as a member
    When I am a regular user
    And I try to visit the user index page I am redirected
    
    When I am a regular user
    And I try to visit the user edit page I am redirected
    
  Scenario: Attempt to edit a user as a non-signed in user
    When I am not signed in
    And I try to visit the user index page I am redirected
    
    When I am not signed in
    And I try to visit the user edit page I am redirected
  
  Scenario: On the edit page I can return to the index page by clicking the View User List Button
    When I am an admin
    And I am on the edit user page
    When I click the View User List Button, I will be redirected the user page