require "rspec"

require_relative "number_to_words"

describe "number to words" do
  numbers = { 0 => "zero", 1 => "one", 2 => "two", 3 => "three" , 4 => "four",
    5 => "five", 6 => "six", 7 => "seven", 8 => "eight", 9 => "nine",
    10 => "ten", 11 => "eleven", 12 => "twelve", 13 => "thirteen",
    14 => "fourteen", 15 => "fifteen", 16 => "sixteen", 17 => "seventeen",
    18 => "eighteen", 19 => "nineteen", 20 => "twenty", 21 => "twenty one",
    22 => "twenty two", 23 => "twenty three", 29 => "twenty nine",
    30 => "thirty", 35 => "thirty five", 40 => "fourty", 41 => "fourty one",
    90 => "ninety", 100 => "one hundred", 200 => "two hundred",
    101 => "one hundred one", 202 => "two hundred two",
    205 => "two hundred five", 210 => "two hundred ten",
    247 => "two hundred fourty seven",
    999 => "nine hundred ninety nine",
    1000 => "one thousand", 1005 => "one thousand five",
    1007 => "one thousand seven",
    2000 => "two thousand", 2001 => "two thousand one",
    3000 => "three thousand", 3100 => "three thousand one hundred",
    9999 => "nine thousand nine hundred ninety nine",
    10000 => "ten thousand",
    99999 => "ninety nine thousand nine hundred ninety nine",
    100001 => "one hundred thousand one" }

  numbers.each do |number, word|
    it "converts #{number} to #{word}" do
      expect(number_to_words(number)).to eq(word)
    end
  end
end
