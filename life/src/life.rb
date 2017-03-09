class Life
  attr_reader :width, :height
  
  def initialize
    @state = Array.new
    @width = 0
    @height = 0
  end

  def clear(width, height)
    @width = width
    @height = height
    
    (0..height-1).each do |y|
      @state[y] = Array.new
      (0..width-1).each do |x|
        @state[y][x] = false
      end
    end
  end
  
  def fill(width, height)
    @width = width
    @height = height
    
    (0..height-1).each do |y|
      @state[y] = Array.new
      (0..width-1).each do |x|
        @state[y][x] = true
      end
    end
  end
  
  def cell(x,y)
    @state[y % @height][x % @width]
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
  
  def format_matrix(alive = "X", dead = ".")
    output = ""
    @state.each do |row|
      row.each do |cell|
        if cell
          output += alive
        else
          output += dead
        end
      end
      output += "\n"
    end
    output
  end
  
  def print_matrix
    print format_matrix
  end
  
  def run(filename, count = 1)
    load(filename)
    iteration = 1
    count.times do
      Kernel.system("clear")
      apply_algorithm
      print_matrix
      output_file = File.basename(filename,".pixels") + "-#{sprintf("%03d",iteration)}.pixels"
      File.write(output_file, format_matrix("1", "0"))
      iteration += 1
      Kernel.sleep(0.5)
    end
  end
  
  def apply_algorithm
    new_life = Life.new
    new_life.clear(width, height)
    
    (0..width-1).each do |x|
      (0..height-1).each do |y|
        neighbors = count_neighbors(x,y)
        state = cell(x,y)
        if state
          if neighbors < 2
            state = false
          elsif neighbors > 3
            state = false
          end
        else
          if neighbors == 3
            state = true
          end
        end
        if state
          new_life.set_cell(x,y)
        else
          new_life.unset_cell(x,y)
        end
      end
    end
    @state = new_life.matrix
  end
  
  def count_neighbors(x,y)
    count = 0
    (x-1..x+1).each do |xx|
      (y-1..y+1).each do |yy|
        next if x == xx && y == yy
        if cell(xx,yy)
          count += 1
        end
      end
    end
    count
  end
end
