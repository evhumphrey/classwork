class Deck

  attr_reader :cards

  VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, :J, :Q, :K, :A]
  SUITS = [:club, :diamond, :heart, :spade]

  def initialize
    @cards = populate_deck
  end

  private

  def populate_deck
    deck = []

    VALUES.each do |value|
      SUITS.each do |suit|
        deck << Card.new(value, suit)
      end
    end

    deck
  end
end
