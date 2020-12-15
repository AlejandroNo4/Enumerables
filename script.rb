# rubocop:disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    i = 0
    while i < to_a.length
      yield to_a[i]
      i += 1
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    i = 0
    while i < to_a.length
      yield to_a[i], i
      i += 1
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    my_new_arr = []
    my_each { |i| my_new_arr.push i if (yield i) == true }
    my_new_arr
  end

  def my_all?(arg = nil)
    if arg
      my_each { |i| return false unless arg.is_a?(Class) && i.is_a?(arg) || arg.is_a?(Regexp) && i.match(arg) }
    elsif block_given?
      my_each { |i| return false unless (yield i) == true }
    else
      my_each { |i| return false if i == false || i.nil? }
    end
    true
  end

  def my_any?(arg = nil)
    if arg
      my_each { |i| return true if arg.is_a?(Class) && i.is_a?(arg) || arg.is_a?(Regexp) && i.match(arg) }
    elsif block_given?
      my_each { |i| return true if (yield i) == true }
    else
      my_each { |i| return true if i }
    end
    false
  end

  def my_none?(arg = nil)
    if arg
      my_each { |i| return false if arg.is_a?(Class) && i.is_a?(arg) || arg.is_a?(Regexp) && i.match(arg) }
    elsif block_given?
      my_each { |i| return false if (yield i) == true }
    else
      my_each { |i| return false if i }
    end
    true
  end

  def my_count(arg = nil)
    counter = 0
    if arg
      my_each { |i| counter += 1 if arg == i }
    elsif block_given?
      my_each { |i| counter += 1 if (yield i) == true }
    else
      my_each { counter += 1 }
    end
    counter
  end

  def my_map(my_proc = nil)
    return to_enum(:my_map) if my_proc.nil? && block_given?.nil?

    my_new_arr = []
    if my_proc
      my_each { |i| my_new_arr << my_proc.call(i) } # It is applyed on itself, so it is not necessary "self.my_each"
    else
      my_each { |i| my_new_arr << yield(i) } # It is applyed on itself, so it is not necessary "self.my_each"
    end
    my_new_arr
  end

  def my_inject(arg = nil, sym = nil)
    if (arg && sym.nil?) && arg.is_a?(Symbol)
      sym = arg
      arg = nil
    end
    if !block_given? && !sym.nil?
      my_each { |item| arg = arg.nil? ? item : arg.send(sym, item) }
    else
      my_each { |item| arg = arg.nil? ? item : yield(arg, item) }
    end
    arg
  end
end

a = [1, 2, 3, 4, 5]

def multiply_els(arr)
  arr.my_inject { |n, i| n * i }
end

puts multiply_els(a)

# rubocop:enable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
