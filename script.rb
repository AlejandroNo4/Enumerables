
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
      to_enum(:my_all?)
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
      to_enum(:my_any?)
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
      to_enum(:my_none?)
    end
    true
  end

  def my_count(req = nil) #req = requested value
    counter = 0
    if req
      my_each {|n| counter+=1 if n == req}
    elsif block_given?
      i = 0
      length.times do
        value = yield self[i]
        counter +=1 if value == true 
        i += 1
      end
    else
      to_enum(:my_count)
    end
    counter
    end

    def my_map
      if block_given?
        i = 0
        my_new_arr = []
        length.times do
          my_new_arr.push yield self[i]
          i += 1
        end
      else
        to_enum(:my_map)
      end
      my_new_arr
    end

    def my_map
      if block_given?
        i = 0
        my_new_arr = []
        length.times do
          my_new_arr.push yield self[i]
          i += 1
        end
      else
        to_enum(:my_map)
      end
      my_new_arr
    end

    def my_map_p (my_proc) #Recives procedures (Proc)
      if my_proc
        i = 0
        my_new_arr = []
        length.times do
          my_new_arr.push my_proc.call(self[i])
          i += 1
        end
      else
        to_enum(:my_map_p)
      end
      my_new_arr
    end

    def my_map_p_b (my_proc = nil) #Recives procedures (Proc)  & blocks
      return to_enum(:my_map_p) if my_proc == nil && block_given? == nil
      my_new_arr = []
      if my_proc
      self.my_each {|i| my_new_arr << my_proc.call(i)}
        else
      self.my_each {|i| my_new_arr << yield(i)}
        end
      my_new_arr
    end

    def my_inject(init = self[0]) #init is the initial value, by default is the first item of self
      if block_given?
        index = 1
        while index < length do
        init =  yield(init, self[index])
        index += 1
        end
        init
      else 
        to_enum(:my_inject)
      end
  end
  
end 



# ********************************** TESTS

a = [1,2,3,4,5,6]



# ********************************** my_map_p test; it only accepts Procs
#plus_two = Proc.new {|n| n + 2}
#print a.my_map_p(plus_two)

# ********************************** my_map_p_b test; it accepts Procs & blocks
#plus_two = Proc.new {|n| n + 2}
#print a.my_map_p_b(plus_two)

#print a.my_map_p_b {|n| n+2}

# ********************************** multiply_els method test, this test the my_inject method of the Enumerables module
=begin

def multiply_els(arr)
  arr.my_inject {|n, i| n*i}
end

puts multiply_els(a)

=end

# ********************************** tests for the rest of the methods, first the created in here, second the ones that already exixt

#a.my_each {|n| puts n + 5 + 2}
#a.my_each_with_index {|n, i| print n + 5, i}
#print a.my_select {|n| n > 2}
#puts a.my_all? {|n| n > 9}
#puts a.my_any? {|n| n < 9}
#puts a.my_none? {|n| n == 4}
#puts a.my_count {|n| n > 2}, a.my_count(4)
#print a.my_map {|n| n+2}, a.my_map {}
#puts a.my_inject {|pr ,n| pr * n}

#a.each {|n| puts n + 5 + 2}
#a.each_with_index {|n, i| print n + 5, i}
#print a.select {|n| n > 2}
#puts a.all? {|n| n > 9}
#puts a.any? {|n| n < 9}
#puts a.none? {|n| n == 4}
#puts a.count {|n| n > 2}, a.count(4)
#print a.map {|n| n+2}, a.map {}
#puts a.inject {|pr ,n| pr * n}




