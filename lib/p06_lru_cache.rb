require_relative 'p05_hash_map'
require_relative 'p04_linked_list'


class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      update_link!(@map[key])
      @map[key].val
    else
      val = @prc.call(key)
      new_link = @store.append(key, val)
      @map[key] = new_link
      eject! if count > @max
      val
    end

  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
  end

  def update_link!(link)
    # suggested helper method; move a link to the end of the store
    key = link.key
    val = link.val
    link.remove
    @store.append(key, val)
  end

  def eject!
    key = @store.first.key
    @store.remove(key)
    @map.delete(key)
  end
end
