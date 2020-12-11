module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?
    i = 0
    length.times do
      yield self[i]
      i += 1
    end
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?
    i = 0
    length.times do
      yield self[i], i
      i += 1
    end
  end

  def my_select
    return to_enum(:my_select) unless block_given?
    i = 0
    my_new_arr = [] # It will return a new array
    length.times do
      value = yield self[i]
      my_new_arr.push self[i] unless value == true
      i += 1
    end
    my_new_arr
  end

  def my_all?
    return to_enum(:my_all?) unless block_given?
    i = 0
    length.times do
      value = yield self[i]
      return false if value == false
      i += 1
    end
    true
  end

  def my_any?
    return to_enum(:my_any?) unless block_given?
    i = 0
    length.times do
      value = yield self[i]
      return true if value == true
      i += 1
    end
    false
  end

  def my_none?
    return to_enum(:my_none?) unless block_given?
    i = 0
    length.times do
      value = yield self[i]
      return false if value == true
      i += 1
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

# ************* multiply_els method test, this test the my_inject method of the Enumerables module

def multiply_els(arr)
  arr.my_inject { |n, i| n * i }
end

puts multiply_els(a)

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
