module Enumerable
  def my_each
    return to_enum unless block_given?
    counter = 0
    while counter < object.size
      yield(self[counter])
      counter += 1
    end
    self
  end

  def my_each_with_index
    return to_enum unless block_given?
    index = 0
    while index < size
      yield(self[index], index)
      index += 1
    end
    self
  end

  def my_select
    return to_enum unless block_given?
    arr = []
    my_each do |x|
      arr << x if yield(x)
    end
    arr
  end

  def my_all?(arg = nil)
    if block_given?
      my_each { |elem| return false unless yield(elem) }
    end
    if arg.nil?
      my_each { |elem| return false unless elem }
      return true
    end
    my_each { |elem| return false unless check_validity(elem, arg) }
    true
  end

  def my_any?(arg = nil, &proc)
    if block_given?
      my_each { |elem| return true if proc.nil? yield(elem) }
    else
      my_each { |elem| return true if arg.nil? ? elem : check_validity(elem, arg) }
    end
    false
  end

  def my_none?(pattern = nil, &proc)
    !my_any?(pattern, &proc)
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
