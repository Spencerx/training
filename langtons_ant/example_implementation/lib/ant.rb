class Ant
  WEST = 0
  NORTH = 1
  EAST = 2
  SOUTH = 3

  attr_accessor :x, :y, :direction
  
  def initialize(world)
    @world = world
    @x = 5
    @y = 5

    @direction = WEST
  end

  def turn_left
    @direction = ( @direction - 1 ) % 4
  end

  def turn_right
    @direction = (@direction + 1) % 4
  end

  def step
    case @direction
    when WEST
      self.x -= 1
    when NORTH
      self.y += 1
    when EAST
      self.x += 1
    when SOUTH
      self.y -= 1
    end
  end

  def move
    turn_left if @world.black?(x, y)
    turn_right if @world.white?(x, y)

    @world.flip(x, y)

    step
  end
end
