Feature: Unauthenticated Requests
  Scenario: Viewing teams
    When I view the teams page
    Then I am asked to sign in

  Scenario: Viewing a team
    When there is a team named "PLF"
    And I view the "PLF" team page
    Then I am asked to sign in
