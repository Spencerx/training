require_relative 'spec_helper'

describe GameController do
  describe "#initialize" do
    it "sets up a Game" do
      expect(subject.game).to be_a(Game)
    end
  end

  describe "#run" do
  end
end
