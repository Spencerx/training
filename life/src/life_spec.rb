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
  
  describe "#fill" do
    it "fills (1,1) matrix" do
      subject.fill(1,1)
      expect(subject.cell(0,0)).to eq(true)
    end

    it "fills (3,1) matrix" do
      subject.fill(3,1)
      expect(subject.matrix).to eq([[true, true, true]])
    end
    
    it "fills (2,2) matrix" do
      subject.fill(2,2)
      expect(subject.matrix).to eq([[true, true], [true, true]])
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
  
  describe "#format_matrix" do
    before do
      subject.clear(3,2)
      subject.set_cell(2,1)
    end
    
    it "formats matrix" do
      expected_output = <<EOT
...
..X
EOT
      expect(subject.format_matrix).to eq(expected_output)
    end
    
    it "formats matrix with given symbols" do
      expected_output = <<EOT
000
001
EOT
      expect(subject.format_matrix("1","0")).to eq(expected_output)
    end
  end
  
  describe "#run" do
    before do
      expect(subject).to receive(:load).with("glider.pixels")
    end
  
    it "executes one cycle of life" do
      expect(Kernel).to receive(:system).with("clear")
      expect(subject).to receive(:apply_algorithm)
      expect(subject).to receive(:print_matrix)
      expect(Kernel).to receive(:sleep)
      expect(File).to receive(:write).with("glider-001.pixels", anything)

      subject.run("glider.pixels")
    end
    
    it "executes three cycles of life" do
      expect(Kernel).to receive(:system).with("clear").exactly(3).times
      expect(subject).to receive(:apply_algorithm).exactly(3).times
      expect(subject).to receive(:print_matrix).exactly(3).times
      expect(Kernel).to receive(:sleep).exactly(3).times      
      expect(File).to receive(:write).with("glider-001.pixels", anything)
      expect(File).to receive(:write).with("glider-002.pixels", anything)
      expect(File).to receive(:write).with("glider-003.pixels", anything)

      subject.run("glider.pixels", 3)
    end
  end
  
  describe "#apply_algorithm" do
    it "kills all cells" do      
      subject.clear(3,3)

      # 110
      # 100
      # 101
      subject.set_cell(0,0)
      subject.set_cell(0,1)
      subject.set_cell(1,0)
      subject.set_cell(2,0)
      subject.set_cell(2,2)

      expect(subject.matrix).to eq([
        [ true,  true, true],
        [ true, false, false],
        [false, false, true]
      ])

      subject.apply_algorithm
      
      expect(subject.matrix).to eq([
        [false, false, false],
        [false, false, false],
        [false, false, false]
      ])
    end

    it "blinker" do      
      subject.clear(5,5)

      # 00000
      # 00100
      # 00100
      # 00100
      # 00000
      subject.set_cell(2,1)
      subject.set_cell(2,2)
      subject.set_cell(2,3)

      expect(subject.matrix).to eq([
        [false, false, false, false, false],
        [false, false,  true, false, false],
        [false, false,  true, false, false],
        [false, false,  true, false, false],
        [false, false, false, false, false]
      ])

      subject.apply_algorithm
      
      expect(subject.matrix).to eq([
        [false, false, false, false, false],
        [false, false, false, false, false],
        [false,  true,  true,  true, false],
        [false, false, false, false, false],
        [false, false, false, false, false]
      ])
    end
  end

  context "empty matrix" do
    before do
      subject.clear(3,3)
    end
    
    describe "#count_neighbors(1,0)" do
      it "returns 0" do
        expect(subject.count_neighbors(1,0)).to eq(0)
      end
    end
    
    describe "#count_neighbors(1,1)" do
      it "returns 0" do
        expect(subject.count_neighbors(1,1)).to eq(0)
      end
    end
  end
    
  context "full matrix" do
    before do
      subject.fill(3,3)
    end
    
    describe "#count_neighbors(1,0)" do
      it "returns 8" do
        expect(subject.count_neighbors(1,0)).to eq(8)
      end
    end
    
    describe "#count_neighbors(1,1)" do
      it "returns 8" do
        expect(subject.count_neighbors(1,1)).to eq(8)
      end
    end
  end
    
  context "mixed matrix" do
    before do
      subject.clear(3,3)

      # 110
      # 100
      # 101
      subject.set_cell(0,0)
      subject.set_cell(0,1)
      subject.set_cell(1,0)
      subject.set_cell(2,0)
      subject.set_cell(2,2)
    end

    describe "#count_neighbors(1,0)" do
      it "returns 4" do
        expect(subject.count_neighbors(1,0)).to eq(4)
      end
    end
    
    describe "#count_neighbors(1,1)" do
      it "returns 5" do
        expect(subject.count_neighbors(1,1)).to eq(5)
      end
    end
  end
end
