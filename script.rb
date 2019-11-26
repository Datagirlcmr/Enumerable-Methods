# frozen_string_literal: true

module Enumerable
  def my_each
    return to_enum unless block_given?

    counter = 0
    while counter < size
      yield(self[counter])
      counter += 1
    end
    self
  end

  def my_each_with_index
    return to_enum unless block_given?

    counter = 0
    while counter < size
      yield(self[counter], counter)
      counter += 1
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

  def my_all?(pattern = nil)
    if block_given?
      my_each do |x|
        return false unless yield(x)
      end
    elsif !pattern.nil?
      if pattern.is_a?(Class)
        my_each do |x|
          return false unless x.is_a?(pattern)
        end
      elsif pattern.is_a?(Regexp)
        my_each do |x|
          return false unless pattern.match(x.to_s)
        end
      else
        my_each do |x|
          return false unless x == pattern
        end
      end
    else
      my_each do |x|
        return false unless x
      end
    end
    true
  end

  def my_any?(patter = nil)
    if block_given?
      my_each do |x|
        return true if yield(x)
      end
    elsif !patter.nil?
      if patter.is_a?(Class)
        my_each do |x|
          return true if x.is_a?(patter)
        end
      elsif patter.is_a?(Regexp)
        my_each do |x|
          return true if patter.match(x.to_s)
        end
      else
        my_each do |x|
          return true if x == patter
        end
      end
    else
      my_each do |x|
        return true if x
      end
    end
    false
  end

  def my_none?(pat = nil)
    if block_given?
      my_each do |x|
        return false if yield(x)
      end
    elsif !pat.nil?
      if pat.is_a?(Class)
        my_each do |x|
          return false if x.is_a?(pat)
        end
      elsif pat.is_a?(Regexp)
        my_each do |x|
          return false if pat.match(x.to_s)
        end
      else
        my_each do |x|
          return false if x == pat
        end
      end
    else
      my_each do |x|
        return false if x
      end
    end
    true
  end

  def my_count(element = nil)
    total = 0
    if block_given?
      my_each do |x|
        total += 1 if yield(x)
      end
    elsif element
      my_each do |x|
        total += 1 if x == element
      end
    else
      total = size
    end
    total
  end

  def my_map
    return to_enum unless block_given?

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
