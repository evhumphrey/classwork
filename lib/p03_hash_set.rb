require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    unless include?(key)
      resize! if num_buckets == count
      self[key] << key
      @count += 1
    end
  end

  def include?(key)
    self[key].any? { |object| object == key }
  end

  def remove(key)
    self[key].delete(key)
  end

  private

  def [](key)
    @store[key.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    copy = Array.new(num_buckets * 2) { Array.new }
    @store.each do |bucket|
      bucket.each do |el|
        copy[el.hash % (num_buckets * 2)] << el
      end
    end
    @store = copy
  end
end
