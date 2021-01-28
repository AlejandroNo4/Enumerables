require_relative '../enumerables'

describe Enumerable do
  describe '.my_each' do
    it 'for every element in the array, each runs the block' do
      sum = 5
      [1, 2, 3].my_each { |a| sum += a }
      expect(sum).to eql(11)
    end

    it 'returns Enumerable if no block is given' do
      res = [1, 2, 3].my_each
      expect(res.is_a?(Enumerable)).to eql(true)
    end
  end
end

describe Enumerable do
  describe '.my_each' do
    let(:test_one) { [1, 2, 3].my_each { |a| a + 1 } }
    it 'tests the BAD USAGE of .my_each, this will return the same array' do
      expect(test_one).not_to eql([2, 3, 4])
    end
  end
end

describe Enumerable do
  describe '.my_each_with_index' do
    it 'besides the element, now it has the value of the index' do
      sum_ewi = 5
      [1, 2, 3, 4, 5, 6].my_each_with_index { |n, i| sum_ewi += n if i > 3 }
      expect(sum_ewi).to eql(16)
    end

    it 'returns Enumerable if no block is given (this time is a negative scenario)' do
      arr = [1, 2, 3, 4, 5, 6].my_each_with_index
      expect(arr.is_a?(Enumerable)).not_to eql(false)
    end
  end
end

describe Enumerable do
  describe '.my_each_with_index' do
    let(:test_one) { [1, 2, 3].my_each_with_index { |a, i| a + i } }
    it 'tests the BAD USAGE of .my_each_with_index, this will NOT return the sum from test_one' do
      expect(test_one).not_to eql([1, 3, 5])
    end
  end
end

describe Enumerable do
  describe '.my_select' do
    it 'returns an array containing the values that are true from the block' do
      res_arr = [1, 2, 3, 4, 5].my_select(&:even?)
      expect(res_arr).to eql([2, 4])
    end

    it 'returns Enumerable if no block is given' do
      no_block = [1, 2, 3, 4, 5].my_select
      expect(no_block.is_a?(Enumerable)).to eql(true)
    end
  end
end

describe Enumerable do
  describe '.my_select' do
    it 'tests the BAD USAGE of .my_select, the method ALWAYS will return a new array' do
      res = [1, 2, 3, 4, 5]
      res.my_select { |a| a > 2 }
      expect(res).not_to eql([3, 4, 5])
    end
  end
end

describe Enumerable do
  describe '.my_all?' do
    let(:test_one) { %w[ant bear cat].my_all? { |word| word.length >= 3 } }
    let(:test_two) { %w[ant bear cat].my_all? { |word| word.length >= 4 } }
    let(:test_three) { [1, 2i, 3.14].my_all?(Numeric) }
    let(:test_four) { [].my_all? }
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
  describe '.my_all?' do
    it 'tests the BAD USAGE of .my_all. With hashes, each key/value is passed as two-valued array' do
      ages = { 'bob' => 22, 'Jay' => 32 }
      expect(ages.my_all?(Numeric)).not_to eql(true)
    end
  end
end

describe Enumerable do
  describe 'my_any?' do
    let(:test_one) { %w[ant bear cat].my_any? { |word| word.length >= 3 } }
    let(:test_two) { %w[ant bear cat].my_any? { |word| word.length >= 4 } }
    let(:test_three) { [1, 2i, 3.14].my_any?(Integer) }
    let(:test_four) { [nil, true, 99].my_any? }
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

      it 'without a block or parameter, it will always be true unless one of the values is nil or false' do
        expect(test_four).to eql(true)
      end
    end
  end
end

describe Enumerable do
  describe '.my_any?' do
    it 'tests the BAD USAGE of .my_all. With hashes. Empty array or hash, will always be false' do
      a = []
      expect(a.my_any?).not_to eql(true)
    end
  end
end

describe Enumerable do
  describe 'my_none?' do
    let(:test_one) { %w[ant bear cat].my_none? { |word| word.length == 5 } }
    let(:test_two) { %w[ant bear cat].my_none? { |word| word.length >= 4 } }
    let(:test_three) { [nil, false, true].my_none? }
    let(:test_four) { [].my_none? }

    context 'returns true if the block never returns true for all elements' do
      it 'test one to true' do
        expect(test_one).to eql(true)
      end

      it 'test example two to be not equal to false' do
        expect(test_two).not_to eql(true)
      end
    end

    context 'if the block is not given, return true if none of the elements is true' do
      it 'test example three to be true' do
        expect(test_three).to eql(false)
      end

      it 'test example three to be true' do
        expect(test_four).not_to eql(false)
      end
    end
  end
end

describe Enumerable do
  describe '.my_none?' do
    it 'tests the BAD USAGE of .my_none. With hashes, this will return true unless the poarameter Object' do
      ages = { 'bob' => 22, 'Jay' => 32 }
      expect(ages.my_none?(Numeric)).not_to eql(false)
    end
  end
end

describe Enumerable do
  describe 'my_count' do
    let(:arr_test) { [1, 2, 4, 2] }
    let(:arr_with_block) { arr_test.my_count(&:even?) }

    context 'returns the number of items in the array' do
      it 'counts the elements to be four' do
        expect(arr_test.my_count).to eql(4)
      end

      it 'counts the elements with an argument' do
        expect(arr_test.my_count(2)).to eql(2)
      end

      it 'counts the elements with a block' do
        expect(arr_with_block).to eql(3)
      end
    end
  end
end

describe Enumerable do
  describe '.my_count' do
    it 'tests the BAD USAGE of .my_none. A parameter biger than the length, will return 0' do
      ary = [1, 2, 4, 2]
      expect(ary.count(5)).not_to eql(5)
    end
  end
end

describe Enumerable do
  describe 'my_map' do
    it 'returns a new array with the results of running block once for every element in the array' do
      res = [1, 2, 3, 4].my_map { |i| i * i }
      expect(res).to eql([1, 4, 9, 16])
    end

    it 'returns Enumerable if no block is given' do
      no_block = [1, 2, 3, 4].my_map
      expect(no_block.is_a?(Enumerable)).to eql(true)
    end
  end
end

describe Enumerable do
  describe '.my_map' do
    it 'tests the BAD USAGE of .my_map. the method ALWAYS will return a new array' do
      res = [1, 2, 3]
      res.my_map { |a| a * 2 }
      expect(res).not_to eql([2, 4, 6])
    end
  end
end

describe Enumerable do
  describe 'my_inject' do
    let(:test_one) { [5, 6, 7, 8, 9, 10].my_inject { |sum, n| sum + n } }
    let(:test_two) { [5, 6, 7, 8, 9, 10].my_inject(:+) }
    let(:test_three) { [5, 6, 7, 8, 9, 10].my_inject(1, :*) }
    it 'combines all elements inside of the array' do
      expect(test_one).to eql(45)
    end

    it 'uses a symbol that names the operator' do
      expect(test_two).to eql(45)
    end

    it 'uses a symbol that names the operator and specify an initial value' do
      expect(test_three).to eql(151_200)
    end
  end
end

describe Enumerable do
  describe '.my_inject' do
    it 'tests the BAD USAGE of .my_map. when passed over each key-value, it converts it first into an array' do
      hashy = { 'one' => 1, 'two' => 2, 'three' => 3 }
      res = hashy.inject { |sum, n| sum + n }
      expect(res).not_to eql(6)
    end
  end
end
