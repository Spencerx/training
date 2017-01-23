require_relative 'spec_helper'

describe Game do
  describe '#initialize' do
    it 'initializes a game class with score 0, no answers and a generated string' do
      expect(subject.answers.uniq).to eq([nil])
      expect(subject.string).to match(/[A-Z]+/)
    end
  end

  describe '#next_char' do
    it 'returns a char' do
      subject.string.chars.each do |char|
        expect(subject.next_char).to eq(char)
      end
      expect(subject.next_char).to eq(nil)
    end
  end

  describe '#record_answer' do
    it 'records an answer' do
      subject.string.length.times do
        subject.next_char
        subject.record_answer(true)
      end

      expect(subject.answers.uniq).to eq([true])
      expect(subject.answers.length).to eq(subject.string.length)
    end
    it 'records an answer' do
      subject.string.length.times do
        subject.next_char
        subject.record_answer(false)
      end

      expect(subject.answers.uniq).to eq([false])
      expect(subject.answers.length).to eq(subject.string.length)
    end
  end

  describe '#score' do
    it 'recognizes wrong answers' do
      subject.string = "FOOBAR"
      subject.answers = Array.new(subject.string.length, true)
      expect(subject.score).to eq(0.0)
    end

    it 'recognizes correct answers' do
      subject.string = "FOOBAR"
      subject.answers = Array.new(subject.string.length, false)
      expect(subject.score).to eq(1.0)
    end
    it 'recognizes partially given correct answers' do
      subject.string = "FOOBAR"
      subject.answers = Array.new(subject.string.length / 2, false)
      expect(subject.score).to eq(1.0)
    end

    it 'recognizes correct key presses' do
      subject.string = "FOOFOO"
      subject.answers = [false, false, false, true, true, true] 
      expect(subject.score).to eq(1.0)
    end

    it 'recognizes partially correct key presses' do
      subject.string = "FOOFOOFOO"
      subject.answers = [false, false, false, true, true, true, false, false, false] 
      expect(subject.score).to eq(2.0/3)
    end
  end
end
