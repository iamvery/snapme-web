Feature: Managing Teams
  Background:
    Given I am signed in

  Scenario: Adding a team
    When I view the teams page
    And I add a team named "PLF"
    Then I see the team "PLF"
