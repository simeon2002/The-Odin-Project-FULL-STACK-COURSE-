module Enumerable
  def my_each_with_index
    for i in (0...self.length)
      yield(self[i], i)
    end
    self
  end

  def my_select
    matched = []
    self.my_each do |el|
      matched << el if yield(el) # if condition true, item will be added.
    end
    matched
  end

  def my_all?
    self.my_each do |el|
      return false unless yield(el)
    end
    true
  end

  def my_any?
    self.my_each do |el|
      return true if yield(el)
    end
    false
  end

  def my_none?
    self.my_each do |el|
      return false if yield(el) # if the block returns true, then at least one matches the condition and we return false.
    end
    true
  end

  def my_count
    return self.length unless block_given?

    count = 0
    self.my_each do |el|
      count += 1 if yield(el)
    end

    count
  end

  def my_map(&proc)
    new_arr = []
    self.my_each do |el|
      new_arr << proc.call(el)
    end
    new_arr
  end

  def my_inject(accumulator = nil, &proc)
    self.each do |el|
      accumulator = proc.call(accumulator, el) # arg accumulator contains the previous value which can be used inside of the block.
    end

    accumulator
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  # Define my_each here
  def my_each()
    for el in self
      yield(el)
    end
    self
  end
end
