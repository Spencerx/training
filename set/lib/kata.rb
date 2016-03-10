class Kata
    attr_accessor :content
    def initialize
        @content = Array.new
    end
    def add(o)
        @content << o if @content.count(o) < 1
    end
    def remove(o)
        @content.delete(o)
    end
    def contains?(o)
        @content.count(o) > 0
    end
    def equals?(k)
        k.content == @content
    end
    def each
        @content.each
    end
    def size
        @content.size
    end
    def empty?
        @content.empty?
    end
    def to_a
        @content
    end
end

