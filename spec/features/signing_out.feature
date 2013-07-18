Feature: Signing out
  Scenario: User signs out
    When I am signed in
    And I sign out
    Then I see that I'm signed out
