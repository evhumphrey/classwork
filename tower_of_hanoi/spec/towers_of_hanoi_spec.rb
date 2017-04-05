require 'rspec'
require 'towers_of_hanoi'

describe TowersOfHanoi do
  subject(:game) { TowersOfHanoi.new }
  let(:start_tower_state) { [[3, 2, 1], [0, 0, 0], [0, 0, 0]] }
  context '#initialize' do
    it 'sets towers' do
      expect(game.towers).to_eq(start_tower_state)
    end
  end

  context '#move' do
    let(:same_tower_error) { "Invalid move: can't move on same tower" }
    let(:big_on_small_error) { "Invalid move: can't place bigger disk on smaller disk" }

    it 'prevents user from moving disk from a tower to the same tower' do
      expect { game.move(0, 0) }.to raise_error(same_tower_error)
    end

    it 'prevents user from moving bigger disk on to a smaller disk' do
      game.move(0, 1)
      expect { game.move(0, 1) }.to raise_error(big_on_small_error)
    end

    it 'moves a disk from one tower to another' do
      game.move(0, 1)
      expect(game.towers).to_eq([3, 2, 0], [1, 0, 0], [0, 0, 0])
    end
  end

  context '#won?' do
    let(:win_one) { [[0, 0, 0], [3, 2, 1], [0, 0, 0]] }
    let(:win_two) { [[0, 0, 0], [0, 0, 0], [3, 2, 1]] }

    it 'returns true when second tower has complete stack of disks' do
      expect(game.towers == win_one).to eq(game.won?)
    end

    it 'returns true when second tower has complete stack of disks' do
      expect(game.towers == win_two).to eq(game.won?)
    end

    it 'returns false when starting tower has complete stack' do
      expect(game.won?).to be false
    end
  end
end
