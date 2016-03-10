require "rspec"

require_relative "number_to_words"

describe "number to words" do
  numbers = ["zero", "one", "two", "three"]

  numbers.each_with_index do |word, number|
    it "converts #{number} to #{word}" do
      expect(number_to_words(number)).to eq(word)
    end
  end
end
