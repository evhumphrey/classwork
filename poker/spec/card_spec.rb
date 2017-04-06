require 'rspec'
require 'card'

describe Card do
  subject(:card) { Card.new(5, :heart) }

  context '#initialize' do

    it 'sets the card value' do
      expect(card.value).to eq(5)
    end

    it 'sets the card suit' do
      expect(card.suit).to eq(:heart)
    end
  end

end
