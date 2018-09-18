class ValuesPage
  include PageObject
  include PageObject::PageFactory

  page_url 'https://www.exercise1.com/values'

  # Assuming that the labels has the a tag as its not given anywere in the problem statement
  a(:value_one, id: 'lbl_val_1')
  a(:value_two, id: 'lbl_val_2')
  a(:value_three, id: 'lbl_val_3')
  a(:value_four, id: 'lbl_val_4')
  a(:value_five, id: 'lbl_val_5')
  a(:total_balance, id: 'lbl_ttl_val')
  text_field(:text_value_one, id: 'txt_val_1')
  text_field(:text_value_two, id: 'txt_val_2')
  text_field(:text_value_three, id: 'txt_val_3')
  text_field(:text_value_four, id: 'txt_val_4')
  text_field(:text_value_five, id: 'txt_val_5')
  text_field(:total_values, id: 'txt_ttl_val')
  # Assuming there is a table element that has all the values
  table(:values_table, id: 'values_table_test')

  def wait_for_page_to_load
    value_one_element.wait_until_present(timeout: 2)
  end

  # Validate the Values element exists and also validates that the dollor amount is matching with the expected amount
  def validate_values(values, value)
    # This validates if the Value 1, Value 2, .... exists or not
    send("#{values}_element").exists?
    # This validates if the text box values are matching with the values provided in the scenario outline
    if send("text_#{values}") == value
      puts "validated value #{value}"
    else
      raise "Values are not matching #{value}"
    end
  end

  # This validates if the amount in each text box is greater than zero or not
  # I have used the normal way by identifiying each element as a separate object
  # I have created another method if we can identify that all values as a table and can iterate over using hases
  # Method is validate_values_greater_than_zere_using_table
  def validate_values_greater_than_zero
    raise 'Values is less than zero' unless ValuesLib.remove_currency_format(text_value_one) > 0
    raise 'Values is less than zero' unless ValuesLib.remove_currency_format(text_value_two) > 0
    raise 'Values is less than zero' unless ValuesLib.remove_currency_format(text_value_three) > 0
    raise 'Values is less than zero' unless ValuesLib.remove_currency_format(text_value_four) > 0
    raise 'Values is less than zero' unless ValuesLib.remove_currency_format(text_value_five) > 0
    raise 'Values is less than zero' unless ValuesLib.remove_currency_format(total_values) > 0
  end

  # This will simply add the values, I have used the normal way by identifiying each element as a separate object
  # I have created another method if we can identify that all values as a table and can iterate over using hases
  # Method is add_all_values_using_table
  def add_all_values
    ValuesLib.remove_currency_format(text_value_one) + ValuesLib.remove_currency_format(text_value_two_element)
    + ValuesLib.remove_currency_format(text_value_three) + ValuesLib.remove_currency_format(text_value_four)
    + ValuesLib.remove_currency_format(text_value_five)
  end

  def validate_with_total
    raise 'Total is not matching after adding all values' unless add_all_values == ValuesLib.remove_currency_format(total_values)
  end

  # This will simply check the currency format
  # I have used the normal way by identifiying each element as a separate object
  # I have created another method if we can identify that all values as a table and can iterate over using hases
  def validate_currency_format
    raise 'Value is not in currency format' unless ValuesLib.check_currency_format(text_value_one)
    raise 'Value is not in currency format' unless ValuesLib.check_currency_format(text_value_two)
    raise 'Value is not in currency format' unless ValuesLib.check_currency_format(text_value_three)
    raise 'Value is not in currency format' unless ValuesLib.check_currency_format(text_value_four)
    raise 'Value is not in currency format' unless ValuesLib.check_currency_format(text_value_five)
    raise 'Total is not in currency format' unless ValuesLib.check_currency_format(total_values)
  end

  def validate_values_greater_than_zere_using_table  # Sorry method name is too long but trying to explain
    values_table_element.hases.each do |columns|
      raise 'Values is less than zero' unless ValuesLib.remove_currency_format(columns.values[1])
    end
  end

  def add_all_values_using_table
    total = 0
    values_table_element.hases.each_with_index do |columns, index|
      total = total + ValuesLib.remove_currency_format(columns.values[1]) unless index < values_table_element.hases.size # not adding the last row
    end
    total
  end

  def validate_currency_format_using_table
    values_table_element.hases.each do |columns|
      raise 'Value is not in currency format' unless ValuesLib.check_currency_format(columns.values[1])
    end
  end

end