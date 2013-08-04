Feature: Requesting Invitation
  Background:
    Given I have signed in before

  Scenario: Signed out user requests an invitation
    When I request an invitation be sent to "billybob@example.com"
    And I sign in
    Then there is an invitation request for "billybob@example.com"

  Scenario: Signed in user sends requested invitation
    When an invitation has been requested
    And I sign in
    And I send an invitation for the request
    Then there are no invitation requests

