Feature: Example feature

  Scenario: Visit example.com
    Given I open the browser
    When I navigate to "https://example.com"
    Then the page title should be "Example Domain"