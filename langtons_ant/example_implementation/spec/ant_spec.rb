require_relative "spec_helper.rb"

describe Ant do
  let(:world) {
    World.new  
  }

  subject { Ant.new(world) }

  describe "position" do
    it "returns default coordinates" do
      expect(subject.x).to eq(5)
      expect(subject.y).to eq(5)
    end 
  end

  describe "#direction" do
    it "looks left by default" do
      expect(subject.direction).to eq(Ant::WEST)
    end
  end

  describe "#turn_left" do
    it "changes direction" do
      [ Ant::SOUTH, Ant::EAST, Ant::NORTH, Ant::WEST, Ant::SOUTH ].each do |d|
        subject.turn_left
        expect(subject.direction).to eq(d)
      end
    end
  end

  describe "#turn_right" do
    it "changes direction" do
      [ Ant::NORTH, Ant::EAST, Ant::SOUTH, Ant::WEST, Ant::NORTH ].each do |d|
        subject.turn_right
        expect(subject.direction).to eq(d)
      end
    end
  end

  describe "#step" do
    it "makes a step west"do
      subject.step
      expect(subject.x).to eq(4)
      expect(subject.y).to eq(5)
    end

    it "makes a step north"do
      subject.turn_right
      subject.step
      expect(subject.x).to eq(5)
      expect(subject.y).to eq(6)
    end

    it "makes a step east"do
      2.times { subject.turn_right }
      subject.step
      expect(subject.x).to eq(6)
      expect(subject.y).to eq(5)
    end

    it "makes a step east"do
      subject.turn_left
      subject.step
      expect(subject.x).to eq(5)
      expect(subject.y).to eq(4)
    end
  end

  describe "#move" do
    context "on a white cell" do
      it "rotates right" do
        subject.move

        expect(subject.direction).to eq(Ant::NORTH)
      end

      it "flips the current cell" do
        subject.move
        
        expect(world.black?(5, 5)).to be(true)
      end

      it "does 1 step" do
        expect {
          expect {
            subject.move
          }.to_not change { subject.x }
        }.to change { subject.y }.by(1)
      end
    end

    context "on a black cell" do
      before(:each) do
        world.flip(5, 5)
      end

      it "rotates left" do
        subject.move

        expect(subject.direction).to eq(Ant::SOUTH)
      end

      it "flips the current cell" do
        subject.move
        
        expect(world.white?(5, 5)).to be(true)
      end

      it "does 1 step" do
        expect {
          expect {
            subject.move
          }.to_not change { subject.x }
        }.to change { subject.y }.by(-1)
      end
    end
  end
end
