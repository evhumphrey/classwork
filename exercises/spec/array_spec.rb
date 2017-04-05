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
      expect(result_array.equal?(my_array)).to be false
    end

    it 'returns the elements in the order in which they first appeared' do
      expect(result_array).to eq(my_array.uniq)
    end

    it 'has no duplicates in returned array' do
      expect(result_array).to eq(my_array.uniq)
    end
    
  end
end
