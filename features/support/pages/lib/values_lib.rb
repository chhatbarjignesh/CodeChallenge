module ValuesLib

  # This removes the currency format and convert it to float so that we can add
  def remove_currency_format(amount)
    amount.gsub!(/[$,]/, '').to_f
  end
  module_function :remove_currency_format

  # This checks if it is in the currency format or not and return true or false
  def check_currency_format(amount)
    /((\d{3})+(?!\d))/ === amount
  end
  module_function :check_currency_format

end