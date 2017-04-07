class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  # each el (Fixnum); mutliply index.hash by element; add all results
  def hash
    hashing_sum = map.with_index do |el, i|
      el = el.ord if el.is_a?(String) # handles strings as elements
      i.hash * el.hash
    end

    hashing_sum.reduce(:+).hash
  end
end

class String
  BIG_PRIME = 2147483647
  def hash
    # convert stirng to array
    # get hash of array
    # multiply hashing result by 2147483647 (prime)
    self.chars.hash * BIG_PRIME
  end
end

class Hash
  MERSENNE_PRIME = 2305843009213693951
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    #determine order of the hash
    # p self.to_a.sort.hash
    self.to_a.sort.hash * MERSENNE_PRIME
  end
end
