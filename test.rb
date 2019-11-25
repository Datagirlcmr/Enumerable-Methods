module Enumerable
  def my_each
    if block_given?
      counter = 0
      while counter < size
        yield(self[counter])
        counter += 1
      end
    end
    self
  end

  def my_each_with_index
    if block_given?
      counter = 0
      while counter < size
        yield(self[counter], counter)
        counter += 1
      end
    end
    self
  end

  def my_select
    if block_given?
      arr = []
      my_each do |x|
        arr << x if yield(x)
      end
    end
    arr
  end

  def my_all?
    if block_given?
      my_each do |x|
        return false unless yield(x)
      end
      true
    end
  end

  def my_any?
    if block_given?
      my_each do |x|
        return true if yield(x)
      end
    end
    false
  end

  def my_none?
    if block_given?
      my_each do |x|
        return false if yield(x)
      end
      true
    end
  end

  def my_count(element = nil)
    total = 0
    if block_given?
      my_each do |x|
        total += 1 if yield(x)
      end
    elsif !element.nil?
      my_each do |x|
        total += 1 if x == element
      end
    else
      total = size
    end
    total
  end
end

puts [4, 47, 9, 16].my_count
