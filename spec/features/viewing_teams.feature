Feature: Viewing teams
  Background:
    Given there is an existing user
    And there is a team named "PLF"
    And existing user is a part of team "PLF"
    And I have signed in before

  Scenario: Signed out user views teams
    When I view the teams page
    Then I am asked to sign in

  Scenario: Signed out user views a team
    When I view the "PLF" team page
    Then I am asked to sign in

  Scenario: Signed in user sees teams
    When I am signed in
    And I view the teams page
    Then I see the team "PLF"

  Scenario: Signed in user sees images
    When I am signed in
    And I view the "PLF" team page
    Then I see 1 user's snapshot
