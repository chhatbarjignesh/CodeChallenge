
Given(/^I navigate to page$/) do
  visit ValuesPage
  on(ValuesPage).wait_for_page_to_load
end

Then(/^I validated that value displayed for "([^"]*)" should be "([^"]*)"$/) do |values, value|
  on(ValuesPage).validate_values(values, value)
end

And(/^I added all the values$/) do
  on(ValuesPage).add_all_values
end

Then(/^I validated that the value is matching with the value displayed in total balance field$/) do
  on(ValuesPage).validate_with_total
end

Then(/^I validated that the values are formatted as currencies$/) do
  on(ValuesPage).validate_currency_format
end

Then(/^I validated that each value and total balance is greater than (\d+)$/) do
  on(ValuesPage).validate_values_greater_than_zero
end