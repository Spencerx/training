require "rspec"

require_relative "number_to_words"

describe "number to words" do
  it "converts 1 to one" do
    expect(number_to_words(1)).to eq("one")
  end
end
