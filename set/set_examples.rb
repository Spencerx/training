shared_examples "a set" do |value1, value2, value3, value4|
  def iterate(set)
    elements = []
    set.each do |element|
      elements.push(element)
    end
    elements
  end

  context "no values" do
    it "exists" do
      expect(subject).to_not be(nil)
    end

    it "is empty" do
      expect(subject.empty?).to be(true)
    end

    it "is not empty" do
      expect(subject.add(7).empty?).to be(false)
    end

    it "has size 0" do
      expect(subject.size).to eq(0)
    end

    it "adds one element" do
      expect(subject.add(7).size).to eq(1)
    end

    it "equals? returns true on empty sets" do
      expect(subject.equals?(other_subject)).to be(true)
    end

    it "converts empty set to array" do
      expect(subject.to_a).to eq([])
    end

    it "does nothing on empty set" do
      expect(iterate(subject)).to eq([])
    end
  end

  context "one value" do
    it "add returns set" do
      expect(subject.add(value1)).to be(subject)
    end

    it "remove returns set" do
      expect(subject.remove(value1)).to be(subject)
    end

    it "doesn't add same element again" do
      expect(subject.add(value1).add(value1).size).to eq(1)
    end

    it "contains? returns true if element is there" do
      expect(subject.add(value1).contains?(value1)).to be(true)
    end

    it "returns false if set is empty" do
      expect(subject.contains?(value1)).to be(false)
    end

    it "converts one element set to array" do
      expect(subject.add(value1).to_a).to eq([value1])
    end

    it "iterates through one element set" do
      expect(iterate(subject.add(value1))).to eq([value1])
    end

    it "removes element" do
      expect(subject.add(value1).remove(value1).empty?).to be(true)
    end
  end

  context "two different values" do
    it "adds two different elements" do
      expect(subject.add(value1).add(value2).size).to eq(2)
    end

    it "returns false if element is not there in non-empty set" do
      expect(subject.add(value1).contains?(value2)).to be(false)
    end

    describe "#equals" do
      let(:set) { subject.add(value1).add(value2) }

      it "returns false when compared with empty set" do
        expect(set.equals?(other_subject)).to be(false)
      end

      it "returns true when compared with equal two element set" do
        expect(set.equals?(other_subject.add(value1).add(value2))).to be(true)
      end

      it "returns true when compared with equal set created in different order" do
        expect(set.equals?(other_subject.add(value2).add(value1))).to be(true)
      end
    end

    it "removes element from two element set" do
      expect(subject.add(value1).add(value2).remove(value1).to_a).to eq([value2])
    end
  end

  context "two different pairs of two different values" do
    let(:set) { subject.add(value1).add(value2) }

    it "equals? returns false when compared with different two element set" do
      expect(set.equals?(other_subject.add(value3).add(value4))).to be(false)
    end
  end

  context "three different values" do
    it "converts multi element set to array" do
      expect(subject.add(value1).add(value2).add(value3).to_a).to eq(
        [value1, value2, value3]
      )
    end

    it "iterates through multi element set" do
      expect(iterate(subject.add(value1).add(value2).add(value3))).to eq(
        [value1, value2, value3]
      )
    end
  end
end
