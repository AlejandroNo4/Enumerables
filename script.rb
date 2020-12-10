
module Enumerable
  def my_each
    if block_given?
      i = 0
      length.times do
        yield self[i]
        i += 1
      end
    else
      to_enum(:my_each)
    end
  end

  def my_each_with_index
    if block_given?
      i = 0
      length.times do
        yield self[i],i
        i += 1
      end
    else
      to_enum(:my_each_with_index)
    end
  end

  def my_select
    if block_given?
      i = 0
      my_new_arr = [] #It will return a new array
      length.times do
        value = yield self[i]
        my_new_arr.push (self[i]) if value == true
        i += 1
      end
      my_new_arr
    else
      to_enum(:my_select)
    end
  end
end


# ********************************** TESTS

a = [1,2,3,4,5,6]

#a.my_each {|n| puts n + 5 + 2}
#a.my_each_with_index {|n, i| print n + 5, i}

#a.each {|n| puts n + 5 + 2}
#a.each_with_index {|n, i| print n + 5, i}
puts a.my_select {|n| n > 2}