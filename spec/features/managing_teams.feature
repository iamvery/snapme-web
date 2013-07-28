Feature: Managing Teams
  Background:
    Given I am signed in

  Scenario: Adding a team
    When I view the teams page
    And I add a team named "PLF"
    Then I see the team "PLF"

  Scenario: Editing a team
    When there is a team named "PLF"
    And I update the "PLF" team name to "PLFofBNR"
    Then I see the team "PLFofBNR"

  Scenario: Deleting a team
    When there is a team named "PLF"
    And I delete the team named "PLF"
    Then I do not see the team "PLF"
