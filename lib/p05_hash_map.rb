require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap

  include Enumerable

  MAX_BUCKET_SIZE = 5

  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket = bucket(key)
    linked_list = @store[bucket]
    linked_list.include?(key)
  end

  def set(key, val)
    bucket = bucket(key)
    if include?(key)
      @store[bucket].update(key, val)
    else
      @store[bucket].append(key, val)
      @count += 1
      resize! if count == num_buckets
      #resize based on bucket depth, not store length:
      # resize! if @store[bucket].size == MAX_BUCKET_SIZE
    end
  end

  def get(key)
    bucket = bucket(key)
    return nil unless include?(key)
    @store[bucket].get(key)
  end

  def delete(key)
    bucket = bucket(key)
    return nil unless include?(key)
    @store[bucket].remove(key)
    @count -= 1
  end

  def each(&prc)
    @store.each do |bucket|
      bucket.each do |link|
        prc.call(link.key, link.val)
      end
    end
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    copy = Array.new(num_buckets * 2) { LinkedList.new }
    @store.each do |bucket|
      bucket.each do |link|
        bucket_num = link.key.hash % (num_buckets * 2)
        copy[bucket_num].append(link.key, link.val)
      end
    end
    @store = copy
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    key.hash % num_buckets
  end
end
