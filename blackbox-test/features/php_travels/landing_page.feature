@web_ui
@landing
Feature: Landing Page

  Scenario: Should see navigation bar
    When I open landing page
    Then I should be able to see landing page
    And the navigation bar should include the following columns:
      | Column  |
      | HOTELS  |
      | FLIGHTS |
      | TOURS   |
      | CARS    |


  Scenario Outline: Should find appropriate car
    When I open landing page
    And I choose "<option>" tab
    And I select "<pick_up>" and "<drop_off>" location
    And I search query
    Then I should be able to see notification "<message>"
    Examples:
      | option | pick_up    | drop_off | message          |
      | cars   | Manchester | Malaysia | No Results Found |