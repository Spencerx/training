require_relative 'spec_helper'

describe RandomStringGenerator do
  describe '.generate' do
    it 'returns a string within the alphabet' do
      expect(described_class.generate).to match(/[A-Z]+/)
    end

    it 'returns a string of the specified length' do
      expect(described_class.generate(5).length).to eq(5)
    end

    it 'returns a string with the same at each index' do
      random_string = described_class.generate(5, 1)
      expect(random_string[0]).to eq(random_string[3])
      expect(random_string[1]).to eq(random_string[4])
    end

    it 'returns no matches if probability is 0' do
      stub_const("RandomStringGenerator::ALPHABET", ["A", "B"])
      random_string = described_class.generate(5, 0)
      expect(random_string[0]).to_not eq(random_string[3])
      expect(random_string[1]).to_not eq(random_string[4])
    end
  end
end
