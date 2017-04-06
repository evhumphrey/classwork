require 'rspec'
require 'deck'

describe Deck do
  subject(:deck) { Deck.new }
  let(:values) { [2, 3, 4, 5, 6, 7, 8, 9, 10, :J, :Q, :K, :A] }
  let(:suits) { [:club, :diamond, :heart, :spade] }
  let(:fake_card) { double('card', is_a?: Card) }


  context '#initialize' do
    it 'its size is 52' do
      expect(deck.cards.size).to eq(52)
    end

    it 'is composed of Cards' do
      expect(deck.cards.all? { |el| el.is_a?(Card) }).to be_truthy
    end

    it 'has four of each Card value' do
      value_counts = Hash.new(0)

      deck.cards.each do |card|
        value_counts[card.value] += 1
      end

      card_values = value_counts.values
      expect(card_values.all? { |count| count == suits.length }).to be_truthy
    end

    it 'has four of each Card suit' do
      suit_counts = Hash.new(0)

      deck.cards.each do |card|
        suit_counts[card.suit] += 1
      end

      card_suits = suit_counts.values
      expect(card_suits.all? { |count| count == values.length }).to be_truthy
    end
  end

end
