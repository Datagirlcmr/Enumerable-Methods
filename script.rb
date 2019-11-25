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
    return to_enum unless block_given?

    my_each do |x|
      return false unless yield(x)
    end
    true
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
    return to_enum unless block_given?

    my_each do |x|
      return false if yield(x)
    end
    true
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

  def my_map
    arr = []
    if proc.nil?
      my_each { |x| arr << yield(x) }
    else
      my_each { |x| arr << proc.call(x) }
    end
    arr
  end

  def my_inject(arg_1 = nil, arg_2 = nil)
    (inject, sym, array) = get_inject_and_sym(arg_1, arg_2, to_a.dup, block_given?)
    array.my_each { |i| inject = sym ? inject.send(sym, i) : yield(inject, i) }
    inject
  end

  def get_inject_and_sym(arg1, arg2, arr, block)
    arg1 = arr.shift if arg1.nil? && block
    return [arg1, nil, arr] if block
    return [arr.shift, arg1, arr] if arg2.nil?

    [arg1, arg2, arr]
  end

  def multiply_els(arr)
    arr.inject(1) { |memo, vals| memo * vals }
  end

  def check_validity(entry, param)
    return entry.is_a?(param) if param.is_a?(Class)

    if param.is_a?(Regexp)
      return false if entry.is_a?(Numeric)

      return param.match(entry)
    end
    (entry == param)
  end
end
