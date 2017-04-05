class Array

  def my_uniq
    uniq = []

    self.each do |el|
      uniq << el unless uniq.include?(el)
    end
    
    uniq
  end

end
