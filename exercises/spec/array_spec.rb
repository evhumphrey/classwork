require 'rspec'
require 'array'

describe Array do

  context '#my_uniq' do
    subject(:my_array) { [1, 2, 1, 3, 3] }
    let(:result_array) { my_array.my_uniq }


    it 'returns a new array' do
      expect(result_array).to be_a(Array)
    end

    it 'does not modify receiver' do
      expect(result_array).not_to eql(my_array)
    end

    it 'returns the elements in the order in which they first appeared' do
      expect(result_array).to eq(my_array.uniq)
    end

    it 'has no duplicates in returned array' do
      expect(result_array).to eq(my_array.uniq)
    end
  end

  context '#two_sum' do
    subject(:my_array) { [-1, -1, 0, 2, -2, 1] }
    let(:result_array) { my_array.two_sum }

    context 'returns a new array' do

      it 'result is a new array' do
        expect(result_array).to be_a(Array)
      end

      it 'does not modify reciever' do
        expect(result_array).not_to eql(my_array)
      end

      it 'returns an empty array when receiver is empty' do
        expect([].to_sum).to be_empty
      end

      it 'returns an empty array when receiver size is 1' do
        expect([0].two_sum).to be_empty
      end
    end

    context 'returns pairs that sum to 0, in dictionary-order' do
      #grab just 0th indexes of each pair
      let(:in_order) { result_array.map(&:first) }

      it 'only has position pairs that sum to 0' do
        sums = result_array.map { |pair| pair.first + pair.last }
        all_sums_zero = sums.all? { |sum| sum == 0 }

        expect(all_sums_zero).to be_truthy
      end

      it 'first indexes in pairs are in order' do
        expect(in_order).to eq(in_order.sort)
      end

      context 'when the first position in a pair appears more than once' do
        let(:second_in_order) { [-1, 1, 1].two_sum }
        it 'second indexes are in order' do
          expect(second_in_order).to eq([[0, 1], [0, 2]])
        end
      end
    end
  end

end
