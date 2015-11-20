Feature: Admins should be able to take away or grant admin status to other users
  Scenario: Edit a user's admin status
    When I am an admin
    And there is a user with the name "Dave", the email "dave@gmail.com", and he is "Admin"
    And I am on the user page
    Then I should view the name "Dave", the email "dave@gmail.com", and he is "Admin"
    
    When I have edited "Dave" with email "dave@gmail.com" to be a "Member"
    And I am on the user page
    Then I should view the name "Dave", the email "dave@gmail.com", and he is "Member"