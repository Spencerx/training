class RandomStringGenerator
  ALPHABET = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".chars

  def self.generate(length = 15, prob = 0.2)
    s = ""

    length.times do
      if s.length >= 3 && rand <= prob
        s << s[-3]
      else
        match = s[-3]

        alphabet = match ? (ALPHABET - [match]) : ALPHABET
        s << alphabet.sample
      end
    end
    
    s
  end
end
