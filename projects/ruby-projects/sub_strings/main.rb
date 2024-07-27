require 'debug'

def substrings(str, dictionary)
  str.split(' ').reduce(Hash.new(0)) do |word_count_hash, word|
    dictionary.each do |word_to_compare|
      # debugger
      word_count_hash[word_to_compare.to_sym] += 1 if p word.downcase.include?(word_to_compare)
    end
    word_count_hash
  end
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
# puts "first: " + substrings("below", dictionary).to_s

puts "second: " + substrings("Howdy partner, sit down! How's it going?", dictionary).to_s
