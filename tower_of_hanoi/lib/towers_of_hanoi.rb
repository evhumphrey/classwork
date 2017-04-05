class TowersOfHanoi
  attr_reader :towers

  def initialize
    # treat as psuedo-stacks
    @towers = [
      [3, 2, 1],
      [],
      []
    ]
  end

  def move(start_tower, end_tower)
    # errors
    if start_tower == end_tower
      raise "Invalid move: can't move on same tower"
    end
    if peek(start_tower).nil?
      raise "Invalid move: tower has no disks to move"
    end
    unless peek(end_tower).nil?
      if peek(start_tower) > peek(end_tower)
        raise "Invalid move: can't place bigger disk on smaller disk"
      end
    end

    @towers[end_tower].push(@towers[start_tower].pop)
  end

  def won?
    true if @towers[1].length == 3 || @towers[2].length == 3
    false
  end

  private

  def peek(tower_num)
    return @towers[tower_num].last unless @towers[tower_num].empty?
    nil
  end

end
