Feature: Viewing teams
  Background:
    Given there is an existing user
    And there is a team named "PLF"
    And existing user is a part of team "PLF"
    And I am signed in

  Scenario: User views teams
    When I view the teams page
    Then I see the team "PLF"

  Scenario: User views a team
    When I view the "PLF" team page
    Then I see 1 user's snapshot
