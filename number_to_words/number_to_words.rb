def number_to_words(number)
  words = ["zero", "one", "two", "three", "four", "five", "six", "seven",
    "eight", "nine", "ten", "eleven", "twelve", "thirteen", "fourteen",
    "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"]
  ten_words = [ "zeroty", "ten", "twenty", "thirty", "fourty", "fifty", "sixty",
    "seventy", "eighty", "ninety" ]

  dividers = { 1000 => "thousand", 100 => "hundred" }

  dividers.each do |divider, divider_name|
    if number >= divider
      if number % divider == 0
        return "#{number_to_words(number/divider)} #{divider_name}"
      end
      return "#{number_to_words(number/divider)} #{divider_name} #{number_to_words(number%divider)}"
    end
  end

  if number >= 20
    if number % 10 == 0
      return ten_words[number/10]
    end
    return "#{ten_words[number/10]} #{number_to_words(number%10)}"
  end

  words[number]
end
