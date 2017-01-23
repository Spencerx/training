require_relative 'game'
class GameController
  attr_accessor :game

  def initialize
    @game = Game.new
  end

  def run
    clear_char = `clear`

    while char = @game.next_char 
      response = false

      thread = Thread.new do
        STDIN.getc
        response = true
      end

      print clear_char
      print char
      sleep(1.5)
      
      thread.kill
      game.record_answer(response)
    end

    puts "#{clear_char}Score:#{game.score}"
  end
end
