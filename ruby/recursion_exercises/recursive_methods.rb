def fact(n) # rubocop:disable Naming/MethodParameterName
  return 0 if [1, 0].include?(n)

  fact(n - 1) * n
end

def palindrome(word, index = 0)
  if word.length.odd?
    return true if index == word.length / 2 # when index is at middle

    return false unless word[index] == word[word.length - 1 - index]

    palindrome(word, index + 1)
  elsif word.length.even?
    return false unless word[index] == word[word.length - 1 - index]
    return true if index == word.length - 1

    palindrome(word, index + 1)

  end
end

puts palindrome('pop')

def printBottles(n) # rubocop:disable Naming/MethodName,Naming/MethodParameterName
  if n.zero?
    puts 'No more bottles of beer on the wall.'
    return
  end

  puts "#{n} bottles of beer on the wall."
  printBottles(n - 1)
end

printBottles(5)

def fibonacci(n)
  return 0 if n.zero?

  return 1 if n == 1

  fibonacci(n - 1) + fibonacci(n - 2)
end

puts fibonacci(5)
puts fibonacci(6)

def flatten(element, new_arr = [])
  if element.is_a?(Array)
    element.each do |el|
      flatten(el, new_arr)
    end
  else
    new_arr << element
  end

  new_arr # return value.
end

test_arr = [1, [2, [3, [4, 5]], [6, 7], 8, 9], [10, 11]]
p flatten(test_arr)
p test_arr.flatten

p flatten(1)

def to_roman_numerals(num)
end
