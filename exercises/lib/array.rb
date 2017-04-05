class Array

  def my_uniq
    uniq = []

    self.each do |el|
      uniq << el unless uniq.include?(el)
    end

    uniq
  end

  def two_sum

    return [] if length < 2

    pairs = []
    (0...length).each do |first_pos|
      (first_pos + 1...length).each do |second_pos|
        if self[first_pos] + self[second_pos] == 0
          pairs << [first_pos, second_pos]
        end
      end
    end

    pairs
  end

end
