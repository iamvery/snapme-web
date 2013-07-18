Feature: Signing in
  Scenario: Unauthenticated user must sign in
    When I view the homepage
    Then I am asked to sign in

  Scenario: User signs in with Github
    When I view the homepage
    And I sign in with Github
    Then I see that I'm signed in
