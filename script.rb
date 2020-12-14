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
      my_each{ |i| return false if i == false || i == nil }
    end
    true
  end

  def my_any?(arg = nil)

    if arg
      my_each { |i| return true if arg.is_a?(Class) && i.is_a?(arg) || arg.is_a?(Regexp) && i.match(arg) }
    elsif block_given?
      my_each { |i| return true if (yield i) == true }
    else
      my_each{ |i| return true if i }
    end
    false
  end

  def my_none?(arg = nil)

    if arg
      my_each { |i| return false if arg.is_a?(Class) && i.is_a?(arg) || arg.is_a?(Regexp) && i.match(arg) }
    elsif block_given?
      my_each { |i| return false if (yield i) == true }
    else
      my_each{ |i| return false if i }
    end
    true
  end

  def my_count(req = nil)
    counter = 0
    if req
      my_each { |n| counter += 1 if n == req }
    elsif block_given?
      i = 0
      length.times do
        value = yield self[i]
        counter += 1 if value == true
        i += 1
      end
    else
      to_enum(:my_count)
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

  def my_inject(init = self[0])
    return to_enum(:my_inject) unless block_given?

    index = 1
    while index < length
      init = yield(init, self[index])
      index += 1
    end
    init
  end
end

# ********************************** TESTS ************************

a = [1, 2, 3, 4, 5, 6]


puts %w{ant bear cat}.my_none? { |word| word.length == 5 } #=> true
puts %w{ant bear cat}.my_none? { |word| word.length >= 4 } #=> false
puts %w{ant bear cat}.my_none?(/d/)                        #=> true
puts [1, 3.14, 42].my_none?(Float)                         #=> false
puts [].my_none?                                           #=> true
puts [nil].my_none?                                        #=> true
puts [nil, false].my_none?                                 #=> true
puts [nil, false, true].my_none?                           #=> false



# ************* multiply_els method test, this tests the my_inject method of the Enumerables module
=begin
def multiply_els(arr)
  arr.my_inject { |n, i| n * i }
end

puts multiply_els(a)
=end

# ******* tests for the rest of the methods

# a.my_each {|n| puts n + 5 + 2}
# a.my_each_with_index {|n, i| print n + 5, i}
# print a.my_select {|n| n > 2}
# puts a.my_all? {|n| n > 9}
# puts a.my_any? {|n| n < 9}
# puts a.my_none? {|n| n == 4}
# puts a.my_count {|n| n > 2}, a.my_count(4)
# puts a.my_inject {|pr ,n| pr * n}
# *********************************
# my_map accepts procs and blocks:
# plus_two = Proc.new {|n| n + 2}
# print a.my_map(plus_two)

# print a.my_map {|n| n+2}

# ********************************** MISCELLANEOUS ************************
# Here are two other versions of my_map method: my_map_b, only accepts blocks. And my_map_p, which only accepts procs

# module Enumerable
# def my_map_b
#   if block_given?
#     i = 0
#     my_new_arr = []
#     length.times do
#       my_new_arr.push yield self[i]
#       i += 1
#     end
#   else
#     to_enum(:my_map_b)
#   end
#   my_new_arr
# end

# def my_map_p(my_proc)
#   if my_proc
#     i = 0
#     my_new_arr = []
#     length.times do
#       my_new_arr.push my_proc.call(self[i])
#       i += 1
#     end
#   else
#     to_enum(:my_map_p)
#   end
#   my_new_arr
# end
# end

# ********************************** TESTS ************************

# ************* my_map_p test; it only accepts Procs
# plus_two = Proc.new {|n| n + 2}
# print a.my_map_p(plus_two)

# ************* my_map_p test; it only accepts blocks
# print a.my_map_b {|n| n+2}
