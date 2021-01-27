require_relative '../enumerables'

describe Enumerable do
  describe '.my_each' do
    it 'for every element in the array, each runs the block' do
      sum = 5
      [1, 2, 3].each { |a| sum += a }
      expect(sum).to eql(11)
    end

    it 'returns Enumerable if no block is given' do
      res = [1, 2, 3].each
      expect(res.is_a?(Enumerable)).to eql(true)
    end
  end
end

describe Enumerable do
  describe '.my_each_with_index' do
    it 'besides the element, now it has the value of the index' do
      sum_ewi = 5
      [1, 2, 3, 4, 5, 6].each_with_index { |n, i| sum_ewi += n if i > 3 }
      expect(sum_ewi).to eql(16)
    end

    it 'returns Enumerable if no block is given (this time is a negative scenario)' do
      arr = [1, 2, 3, 4, 5, 6].each_with_index
      expect(arr.is_a?(Enumerable)).not_to eql(false)
    end
  end
end

describe Enumerable do
  describe '.my_select' do
    it 'returns an array containing the values that are true from the block' do
      res_arr = [1,2,3,4,5].my_select { |num|  num.even?  }
      expect(res_arr).to eql([2, 4])
    end

    it 'returns Enumerable if no block is given' do
      no_block = [1,2,3,4,5].my_select
      expect(no_block.is_a?(Enumerable)).to eql(true)
    end
  end
end

describe Enumerable do
  describe '.my_all?' do
    let(:test_one) { %w[ant bear cat].my_all? { |word| word.length >= 3 } }
    let(:test_two) { %w[ant bear cat].all? { |word| word.length >= 4 } }
    let(:test_three) { [1, 2i, 3.14].all?(Numeric) }
    let(:test_four) { [].all? }
    context 'returns true if the block NEVER returns false or nil' do
      it 'test one to true' do
        expect(test_one).to eql(true)
      end

      it 'test example two to false' do
        expect(test_two).not_to eql(true)
      end
    end

    context 'if the block is not given, return true when none of the elements are false or nil' do
      it 'test example three to be true' do
        expect(test_three).to eql(true)
      end

      it 'test example three to be true' do
        expect(test_four).not_to eql(false)
      end
    end
  end
end

describe Enumerable do
  describe 'my_any?' do
    let(:test_one) { %w[ant bear cat].my_any? { |word| word.length >= 3 } }
    let(:test_two) { %w[ant bear cat].any? { |word| word.length >= 4 } }
    let(:test_three) { [1, 2i, 3.14].any?(Integer) }
    let(:test_four) { [].any? }
    context 'returns true if the block ever returns a value OTHER THAN false or nil' do
      it 'test one to true' do
        expect(test_one).to eql(true)
      end

      it 'test example two to be not equal to false' do
        expect(test_two).not_to eql(false)
      end
    end

    context 'if the block is not given, return true if at least of the elements are NOT false or nil' do
      it 'test example three to be true' do
        expect(test_three).to eql(true)
      end

      it 'test example three to be false' do
        expect(test_four).to eql(false)
      end
    end
  end
end
