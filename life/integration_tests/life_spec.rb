require "tmpdir"

describe "life" do
  describe "glider" do
    before(:all) do
      if !system("src/life src/glider.pixels 29")
        raise "Generation of frames failes"
      end
    end

    Dir.glob("integration_tests/reference/glider-*").sort.each do |reference_file|
      it "generates correct #{File.basename(reference_file)}" do
        Dir.mktmpdir do |tmp_dir|
          output_file = File.basename(reference_file)

          expect(File.read(output_file)).to eq(File.read(reference_file))
        end
      end
    end
  end
end
