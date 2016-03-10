require "rspec"

require_relative "number_to_words"

describe "number to words" do
  numbers = { 0 => "zero", 1 => "one", 2 => "two", 3 => "three" }

  numbers.each do |number, word|
    it "converts #{number} to #{word}" do
      expect(number_to_words(number)).to eq(word)
    end
  end
end
