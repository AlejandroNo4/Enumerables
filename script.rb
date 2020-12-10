
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

  def my_all?
    if block_given?
      i = 0
      length.times do
        value = yield self[i]
        return false if value == false
        i += 1
      end
    else
      to_enum(:my_all)
    end
    true
  end

  def my_any?
    if block_given?
      i = 0
      length.times do
        value = yield self[i]
        return true if value == true
        i += 1
      end
    else
      to_enum(:my_any)
    end
    false
  end

  def my_none?
    if block_given?
      i = 0
      length.times do
        value = yield self[i]
        return false if value == true
        i += 1
      end
    else
      to_enum(:my_none)
    end
    true
  end
end


# ********************************** TESTS

a = [1,2,3,4,5,6]

#a.my_each {|n| puts n + 5 + 2}
#a.my_each_with_index {|n, i| print n + 5, i}
#print a.my_select {|n| n > 2}
#puts a.my_all? {|n| n > 9}
#puts a.my_any? {|n| n < 9}
#puts a.my_none? {|n| n == 4}

#a.each {|n| puts n + 5 + 2}
#a.each_with_index {|n, i| print n + 5, i}
#print a.select {|n| n > 2}
#puts a.all? {|n| n > 9}
#puts a.any? {|n| n < 9}
#puts a.none? {|n| n == 4}