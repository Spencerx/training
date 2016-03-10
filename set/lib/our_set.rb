
class OurSet

  def initialize
    @items = []
  end

  def add(item)
    return if contains? item
    @items << item
    self
  end

  def size
    @items.size
  end

  def empty?
    @items.empty?
  end

  def contains?(item)
    @items.include?(item)
  end

  def remove(item)
    @items.delete(item)
    self
  end

  def equals?(other)
    other.each do |i|
      return false unless contains? i
    end
    true
  end

  def each
    @items.each do |i|
      yield i
    end
  end

  def to_a
    @items
  end
end
