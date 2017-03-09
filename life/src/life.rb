class Life
  def initialize
    @state = Array.new
  end

  def clear(width, height)
    (0..height-1).each do |y|
      @state[y] = Array.new
      (0..width-1).each do |x|
        @state[y][x] = false
      end
    end
  end
  
  def cell(x,y)
    @state[y][x]
  end
  
  def set_cell(x,y)
    @state[y][x] = true
  end
  
  def unset_cell(x,y)
    @state[y][x] = false
  end
  
  def matrix
    @state
  end
  
  def load(filename)
    file_content = File.read(filename)
    
    width, height = dimensions(file_content)
    clear(width, height)
    
    y = 0
    file_content.each_line do |line|
      x = 0
      line.each_char do |cell|
        if cell == "1"
          set_cell(x,y)
        end
        x += 1
      end
      y += 1
    end
    
    file_content
  end
  
  def dimensions(content)
    rows = content.split("\n")
    return rows[0].length, rows.count
  end
  
  def print_matrix
    @state.each do |row|
      row.each do |cell|
        if cell
          print "X"
        else
          print "."
        end
      end
      puts
    end
  end
end
