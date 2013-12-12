Feature: Mobile Link
  To use one spec/feature per functionality
  Testers will need to use mobilified page-object functionality on mobile devices

  Background:
    Given I am using a mobile device
    And I navigate to a Manta profile

  Scenario: Finding a link
    When I query the map link
    Then I should receive true

  Scenario: Grabbing a link
    When I ask for the map link element
    Then I should receive the mobile link element

  Scenario: Clicking a link
    When I click the map link
    Then I should land on the map page

