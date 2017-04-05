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
    if !start_tower.between?(0, 2) || !end_tower.between?(0, 2)
      raise "Invalid move: please enter tower numbers between 0 and 2"
    end
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
    return true if @towers[1].length == 3 || @towers[2].length == 3
    false
  end

  def play

    until won?
      render
      begin
        puts "Enter tower to move from:"
        print "> "
        start_tower = gets.chomp.to_i
        puts "Enter tower to move to:"
        print "> "
        end_tower = gets.chomp.to_i
        move(start_tower, end_tower)
      rescue StandardError => e
        render
        puts "#{e}"
        puts "Please try again."
        retry
      end
    end
    puts "Congrats! You win!"
  end


  private

  def peek(tower_num)
    return @towers[tower_num].last unless @towers[tower_num].empty?
    nil
  end

  def render
    system("clear")
    puts "Towers of Hanoi"
    2.downto(0).each do |disk_num|
      0.upto(2).each do |tower_num|

        if @towers[tower_num][disk_num]
          print "  #{@towers[tower_num][disk_num]}  "
        else # tower has no disk here
          print "  |  "
        end
      end
      puts
    end
    3.times do |tower_num|
      print "  #{tower_num}  "
    end
    puts
  end

end

game = TowersOfHanoi.new
game.play
