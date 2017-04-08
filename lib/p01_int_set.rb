class MaxIntSet
  def initialize(max)
    @store = Array.new(max)
  end

  def insert(num)
    @store[num] = true if is_valid?(num)

  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    unless num.between?(1, @store.length)
      raise "Out of bounds"
    end
    true
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    unless include?(num)
      self[num] << num
    end
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].any? { |object| object == num }
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if num_buckets == count
    unless include?(num)
      self[num] << num
      @count += 1
    end

  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].any? { |object| object == num }
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    copy = Array.new(num_buckets * 2) { Array.new }
    @store.each do |bucket|
      bucket.each do |el|
        copy[el % (num_buckets * 2)] << el
      end
    end
    @store = copy
  end
end
