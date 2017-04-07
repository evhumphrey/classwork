class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  # each el (Fixnum); mutliply index.hash by element; add all results
  def hash
    hashing_sum = map.with_index do |el, i|
      i.hash * el
    end

    hashing_sum.reduce(:+).hash
  end
end

class String
  def hash
    
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    0
  end
end
