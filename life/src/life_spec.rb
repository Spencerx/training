require_relative "life"

describe Life do
  describe "#cell" do
    context "empty matrix" do
      before do
        subject.clear(1,1)
      end
      
      it "returns state of cell (0,0)" do
        expect(subject.cell(0,0)).to eq(false)
      end
    end
    
    context "full matrix" do
      before do
        subject.clear(1,1)
        subject.set_cell(0,0)
      end
      
      it "returns state of cell (0,0)" do
        expect(subject.cell(0,0)).to eq(true)
      end
    end
    
    context "partially full one-row matrix" do
      before do
        subject.clear(2,1)
        subject.set_cell(1,0)
      end

      it "returns state of cell (0,0)" do
        expect(subject.cell(0,0)).to eq(false)
      end

      it "returns state of cell (1,0)" do
        expect(subject.cell(1,0)).to eq(true)
      end
    end
  end
  
  describe "#clear" do
    it "clears (1,1) matrix" do
      subject.clear(1,1)
      expect(subject.cell(0,0)).to eq(false)
    end

    it "clears (3,1) matrix" do
      subject.clear(3,1)
      expect(subject.matrix).to eq([[false, false, false]])
    end
    
    it "clears (2,2) matrix" do
      subject.clear(2,2)
      expect(subject.matrix).to eq([[false, false], [false, false]])
    end
  end
  
  describe "#matrix" do
    context "empty 2x1 matrix" do
      before do
        subject.clear(2,1)
      end

      it "returns matrix" do
        expect(subject.matrix).to eq([[false, false]])
      end
    end
  end
  
  describe "#set_cell" do
    it "sets cell" do
      subject.clear(5,5)

      subject.set_cell(2,3)
      
      expect(subject.cell(2,3)).to eq(true)
    end
  end

  describe "#unset_cell" do
    it "clears cell" do
      subject.clear(5,5)
      subject.set_cell(2,3)
      
      subject.unset_cell(2,3)
      
      expect(subject.cell(2,3)).to eq(false)
    end
  end
  
  describe "#load" do
    context "8x8 matrix" do
      let(:expected_content) {
        expected_content = <<EOT
00000000
00000000
00010000
00001000
00111000
00000000
00000000
00000000
EOT
      }
    
      it "reads file and returns file content" do
        expect(subject.load("glider.pixels")).to eq(expected_content)
      end
      
      it "reads file" do
        subject.load("glider.pixels")
        
        expect(subject.matrix).to eq([
          [ false, false, false, false, false, false, false, false ],
          [ false, false, false, false, false, false, false, false ],
          [ false, false, false,  true, false, false, false, false ],
          [ false, false, false, false,  true, false, false, false ],
          [ false, false,  true,  true,  true, false, false, false ],
          [ false, false, false, false, false, false, false, false ],
          [ false, false, false, false, false, false, false, false ],
          [ false, false, false, false, false, false, false, false ]
        ])
      end
    end
  end
  
  describe "#dimensions" do
    it "returns width and height for 1x1 matrix" do
      content = "0\n"
      expect(subject.dimensions(content)).to eq([1,1])
    end

    it "returns width and height for 2x1 matrix" do
      content = "01\n"
      expect(subject.dimensions(content)).to eq([2,1])
    end

    it "returns width and height for 8x8 matrix" do
      content = <<EOT
00000000
00000000
00010000
00001000
00111000
00000000
00000000
00000000
EOT

      expect(subject.dimensions(content)).to eq([8,8])
    end 
    it "returns width and height for 3x2 matrix" do
      content = <<EOT
000
000
EOT

      expect(subject.dimensions(content)).to eq([3,2])
    end 
  end
  
  describe "#print_matrix" do
    it "prints matrix to console" do
      subject.clear(3,2)
      subject.set_cell(2,1)
      
      expected_output = <<EOT
...
..X
EOT

      expect {
        subject.print_matrix
      }.to output(expected_output).to_stdout
    end
  end
end
