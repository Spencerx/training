shared_examples "benchmarks" do |class_benchmarks|
  let(:the_description) do |example|
    example.description
  end

  describe "benchmarks" do
    it "adds 1000 different elements" do
      time = Benchmark.realtime do
        (1..1000).each do |element|
          subject.add(element)
        end
      end
      expect(subject.size).to eq(1000)

      @all_benchmarks[subject.class] ||= {}
      @all_benchmarks[subject.class][the_description] = time
    end

    it "removes 1000 elements" do
      (1..1000).each do |element|
        subject.add(element)
      end
      time = Benchmark.realtime do
        (1..1000).each do |element|
          subject.remove(element)
        end
      end
      expect(subject.size).to eq(0)

      @all_benchmarks[subject.class] ||= {}
      @all_benchmarks[subject.class][the_description] = time
    end

    it "checks for existence on 1000 element set" do
      (1..1000).each do |element|
        subject.add(element)
      end
      time = Benchmark.realtime do
        1000.times do
          expect(subject.contains?(10000)).to be(false)
        end
      end

      @all_benchmarks[subject.class] ||= {}
      @all_benchmarks[subject.class][the_description] = time
    end

    it "adds 20000 same elements" do
      time = Benchmark.realtime do
        20000.times do
          subject.add(42)
        end
      end
      expect(subject.size).to eq(1)

      @all_benchmarks[subject.class] ||= {}
      @all_benchmarks[subject.class][the_description] = time
    end
  end
end
