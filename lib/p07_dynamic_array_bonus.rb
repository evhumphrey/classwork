class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  def length
    @store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray

  include Enumerable

  attr_reader :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    return nil unless i.between?(0, count-1)
    @store[i]
  end

  def []=(i, val)
    @store[i] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
    self.each do |el|
      return true if el == val
    end
    false
  end

  def push(val)
    if count == @store.length
      resize!
    end
    self[count] = val
    @count += 1
  end

  def unshift(val)

    # p "COUNT: #{count} | STORE_LENGTH: #{@store.length}"
    if count == @store.length
      resize!
    end
    (count-1).downto(0) do |i|
      self[i + 1] = self[i]
      p self
    end

    @count += 1
    self[0] = val
    p self
  end

  def pop
    return nil if count == 0
    popped = last
    self[count-1] = nil
    @count -= 1
    popped
  end

  def shift
  end

  def first
    self[0]
  end

  def last
    self[count-1]
  end

  def each(&prc)
    (0...count).each do |i|
      prc.call(self[i])
    end
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    # ...
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    copy_store = StaticArray.new(capacity * 2)

    self.each_with_index do |el, i|
      copy_store[i] = self[i]
    end

    @store = copy_store
  end
end
