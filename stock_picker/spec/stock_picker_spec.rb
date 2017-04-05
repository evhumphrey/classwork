require 'rspec'
require 'stock_picker'

describe '#stock_picker' do
  # mock object for wherever we put #stock_picker
  subject(:stock_prices) { [1.34, 7.90, 4.80, 3.20, 5.15, 1.00] }

    it 'returns a pair of integers' do
      expect(stock_picker(stock_prices)).to eq([1, 5])
    end

    it 'returns nil if no profitable day pair exists' do
      expect(stock_picker([4.00, 5.00])).to be_falsey
    end

    context 'raises an error' do
      let(:no_prices_error) { "No stock prices given" }
      let(:one_price_error) { "Cannot determine days to buy/sell (only one stock price was given)" }
      it 'if argument is not an array' do
        expect { stock_picker(1) }.to raise_error(ArgumentError)
      end

      it 'if there are no stock prices (empty array)' do
        expect { stock_picker([]) }.to raise_error(no_prices_error)
      end

      it 'if there is only one stock price' do
        expect { stock_picker([1.23]) }.to raise_error(one_price_error)
      end
    end
end
