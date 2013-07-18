Feature: Viewing users
  Background:
    Given there is an existing user
    And I have signed in before

  Scenario: Signed out user views users
    When I view the users page
    Then I am asked to sign in

  Scenario: Signed in user sees images
    When I am signed in
    And I view the users page
    Then I see 2 users' snapshots
