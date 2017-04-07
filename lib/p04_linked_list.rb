require 'byebug'

class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    @next.prev = @prev
    @prev.next = @next
  end
end

class LinkedList

  include Enumerable

  def initialize
    #sentinel nodes
    @head = Link.new
    @tail = Link.new

    @head.next = @tail
    @tail.prev = @head

    # size of LinkedList (not counting sentinels)
    @count = 0
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @count == 0
  end

  def get(key)
    self.each do |link|
      return link.val if link.key == key
    end
  end

  def include?(key)
    self.each do |link|
      return true if link.key == key
    end
    false
  end

  def append(key, val)
    new_link = Link.new(key, val)
    prev_link = @tail.prev
    prev_link.next = new_link
    @tail.prev = new_link
    new_link.next = @tail
    new_link.prev = prev_link

    @count += 1
  end

  def update(key, val)
    self.each do |link|
      if link.key == key
        link.val = val
        break
      end
    end
  end

  def remove(key)
    found = nil
    self.each do |link|
      if link.key == key
        found = link
        break
      end
    end
    return nil if found.nil?
    found.prev.next = found.next
    found.next.prev = found.prev
  end

  def each(&prc)
    return if empty?
    current_link = @head.next

    until current_link == @tail
      # debugger
      prc.call(current_link)
      current_link = current_link.next

    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
