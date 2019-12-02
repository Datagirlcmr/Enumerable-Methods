require './script.rb'

RSpec.describe Enumerable do
  let(:my_array) { [1, 2, 3, 4, 5] }
  let(:your_array) { %w[ant bear cat] }

  describe '#my_each' do
    it 'Iterates the given block for each arrayof consecutive <n> elements. ' do
      expect(my_array.my_each { |x| x }).to eql([1, 2, 3, 4, 5])
    end
  end

  describe '#my_select' do
    it 'should return the elements that passes the test' do
      expect(my_array.my_select { |x| x < 3 }).to eql([1, 2])
    end
    it 'should return the multiple of 2' do
      expect(my_array.my_select(&:even?)).to eql([2, 4])
    end

    it 'should return all the integer' do
      expect(my_array.my_select { |x| x.is_a?(Integer) }).to eql(my_array)
    end
  end

  describe '#my_all?' do
    it 'should return true if all elements are less than 3' do
      expect(my_array.my_all? { |x| x < 3 }).to eql(false)
    end

    it 'should return true if the word in an array has 3 letters' do
      expect(your_array.my_all? { |word| word.length >= 3 }).to eql(true)
    end

    it 'should return true if the word in the array has a letter t' do
      expect(your_array.my_all?(/t/)).to eql(false)
    end

    it 'should return true if all the elements in the array are numeric' do
      expect([1, 2i, 3.14].my_all?(Numeric)).to eql(true)
    end

    it 'should return true if the block never returns false or nil' do
      expect([].my_all?).to eql(true)
    end

    it 'returns true when none of the collection members are false' do
      expect([nil, true, 45].my_all?).to eql(false)
    end
  end

  describe '#my_any?' do
    it 'should return true if any element in the array has 3 letters' do
      expect(your_array.my_any? { |word| word.length >= 3 }).to eql(true)
    end

    it 'should return true if any element in the array has a letter d' do
      expect(your_array.my_any?(/d/)).to eql(false)
    end

    it 'should return true if any element in the array is an Integer' do
      expect([nil, true, 99].my_any?(Integer)).to eql(true)
    end

    it 'returns true when any of the collection members have a truthy value' do
      expect([nil, true, 99].my_any?).to eql(true)
    end

    it 'should return true only if the array has any value' do
      expect([].my_any?).to eql(false)
    end
  end

  describe '#my_none?' do
    it 'returns true if no element in the array has 5 letters' do
      expect(your_array.my_none? { |word| word.length == 5 }).to eql(true)
    end

    it 'returns true if no element in the array has a letter d' do
      expect(your_array.my_none?(/d/)).to eql(true)
    end

    it 'returns true if all the elements in the array are Integers' do
      expect([1, 3.14, 42].my_none?(Float)).to eql(false)
    end

    it 'returns true if the array is empty' do
      expect([].my_none?).to eql(true)
    end
  end

  describe '#my_count' do
    it 'returns the number of element in the array' do
      expect(my_array.my_count).to eql(5)
    end

    it 'returns the number of element wich are multiples of 2' do
      expect(my_array.my_count(&:even?)).to eql(2)
    end

    it 'return the number of 3s in the array' do
      expect(my_array.my_count(3)).to eql(1)
    end
  end

  describe '#my_inject' do
    it 'returns the sum of all elements' do
      expect((5..10).my_inject(:+)).to eql(45)
    end
    it 'should multiply the elemets of the array' do
      expect((5..10).my_inject(1, :*)).to eql(151_200)
    end
    it 'should add all the elements of the array starting by 5' do
      expect((5..10).my_inject(5) { |x, y| x + y }).to eql(50)
    end
    it 'should return the longest word in the array' do
      expect(%w[cat sheep bear].my_inject do |memo, word|
               memo.length > word.length ? memo : word
             end).to eql('sheep')
    end
  end
end
