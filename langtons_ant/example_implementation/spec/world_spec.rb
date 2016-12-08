require_relative 'spec_helper.rb'

describe World do
  subject { World.new }

  describe "#black?" do
    specify { expect(subject.black?(0, 0)).to eq(false) }

    it "works on arbitrary coordinates" do
      subject.flip(1, 0)
      expect(subject.black?(0, 0)).to eq(false)
      expect(subject.black?(1, 0)).to eq(true)
    end
  end

  describe "#white?"do
    specify { expect(subject.white?(0, 0)).to eq(true) }

    it "works on arbitrary coordinates" do
      subject.flip(1, 0)
      expect(subject.white?(0, 0)).to eq(true)
      expect(subject.white?(1, 0)).to eq(false)
    end
  end

  describe "#flip" do
    it "flips the color of the cell" do
      subject.flip(0,0)
      expect(subject.black?(0,0)).to be(true)
    end

    it "flips the color of the cell twice" do
      subject.flip(0,0)
      subject.flip(0,0)
      expect(subject.white?(0,0)).to be(true)
    end
  end
  
  describe "#to_s" do
    it "creates a string representation" do
      subject.flip(0, 10)
      subject.flip(0, 9)
      puts subject.to_s
      expect(subject.to_s[0]).to eq("■")
      expect(subject.to_s[1]).to eq("□")
    end
  end
end
