require_relative 'random_string_generator'

class Game
   
  attr_accessor :answers, :string

  def initialize
    @string = RandomStringGenerator.generate
    @answers = Array.new(@string.length, nil)
    @current_position = -1
  end

  def next_char
    @current_position += 1
    string[@current_position]
  end

  def record_answer(answer)
    @answers[@current_position] = answer
  end

  def score
    wrong = 0.0
    correct = 0.0
    (0..@string.length-1).each do |position|
      if position < 3
        if @answers[position] == true
          wrong += 1
        else
          correct += 1
        end 
      elsif @answers[position] == true && @string[position -3] == @string[position]
        correct +=1
      elsif @answers[position] == false && @string[position -3] != @string[position] 
        correct +=1
      elsif @answers[position] != nil
        wrong +=1
      end
    end
    correct/(wrong+correct)
  end
end

