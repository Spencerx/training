require "rspec"
require "benchmark"

require_relative "set_examples"
require_relative "benchmarks_examples"

implementations_path = File.expand_path("../lib", __FILE__)
set_classes = []
Dir.glob(File.join(implementations_path, "*.rb")).each do |set_file|
  require set_file

  class_name = File.basename(set_file, ".rb").split("_").collect(&:capitalize).join
  set_classes.push(Object.const_get(class_name))
end

set_classes.each do |set_class|
  describe set_class do
    let(:other_subject) { set_class.new }

    describe "with integers" do
      it_behaves_like "a set", 7, 3, 5, 8
    end

    describe "with floats" do
      it_behaves_like "a set", 1.0, 2.5, 3.3, -0.2
    end

    describe "with strings" do
      it_behaves_like "a set", "a", "bread", "water", "00"
    end
  end
end

describe "benchmarks" do
  before(:all) do
    @all_benchmarks = {}
  end

  set_classes.each do |set_class|
    describe set_class do
      include_examples "benchmarks"
    end
  end

  after(:all) do
    File.open("benchmarks.csv", "w") do |f|
      benchmarks = @all_benchmarks[@all_benchmarks.keys.first].keys
      f.puts "Benchmark,#{set_classes.join(",")}"
      benchmarks.each do |benchmark|
        line = []
        line.push(benchmark)
        set_classes.each do |set_class|
          line.push(@all_benchmarks[set_class][benchmark])
        end
        f.puts line.join(",")
      end
    end
  end
end
