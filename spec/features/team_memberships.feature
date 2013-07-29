Feature: Team Memberships
  Background:
    Given I am signed in
    And there is a team

  @javascript
  Scenario: Adding self to team
    When I add myself to a team
    Then I see myself on that team

  @javascript
  Scenario: Removing self from team
    When I am on a team
    And I remove myself from a team
    Then I do not see myself on that team
