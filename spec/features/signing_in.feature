Feature: Signing in
  Scenario: Unauthenticated user must sign in
    When I view the homepage
    Then I am asked to sign in

  Scenario: New user attempts sign in without invitation token
    When I view the sign in page without invitation token
    And I sign in with Github
    Then I see that I'm not signed in

  Scenario: New user attempts sign in with invalid invitation token
    When I view the sign in page with an invalid invitation token
    And I sign in with Github
    Then I see that I'm not signed in

  Scenario: New user signs in with a valid invitation token
    When I view the sign in page with a valid invitation token
    And I sign in with Github
    Then I see that I'm signed in
