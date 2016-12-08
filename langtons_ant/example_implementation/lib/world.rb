class World
  BLACK = true
  WHITE = false

  attr_accessor :state

  def initialize
    @state = Array.new(11)
    (0..10).each do |i|
      @state[i] = Array.new(11, WHITE)
    end
  end

  def black?(x, y)
    @state[x][y]
  end
  
  def white?(x, y)
    !@state[x][y]
  end

  def flip(x, y)
    @state[x][y] = !@state[x][y]
  end

  def to_s
    (0..10).map do |row|
      (0..10).map do |cell|
        @state[cell][row] ? "■" : "□"
      end.join
    end.reverse.join("\n")
  end
end
