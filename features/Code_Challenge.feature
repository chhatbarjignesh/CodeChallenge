Feature: As a candidate I need am validating the code challenge for the dummy site



# Scenario one in the presentation shared
  Scenario Outline: Verify the right count of values appear on the screen
    Given I navigate to page
    Then I validated that value displayed for "<values>" should be "<value>"
    Examples:
      | values      | value  	    |
      | value_one   | $122,365.24   |
      | value_two	| $599.00       |
      | value_three	| $850,139.99   |
      | value_four	| $23,329.50    |
      | value_five	| $566.27	    |

# Scenario two in the presentation shared
  Scenario: Verify that the values are greater than zero
    Given I navigate to page
    Then I validated that each value and total balance is greater than 0

# Scenario three and five in the presentation shared
  Scenario: Verify that the total balance is correct based on the values listed on the screen
    Given I navigate to page
    And I added all the values
    Then I validated that the value is matching with the value displayed in total balance field

# scenario four in the presentation shared
  Scenario: Verify that the values are formatted as currencies
    Given I navigate to page
    Then I validated that the values are formatted as currencies