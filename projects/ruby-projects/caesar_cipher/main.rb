def caesar_cipher(str, key)
  string_ASCII = str.bytes
  return string_ASCII.map do |char_key|
    char_key += key
    if char_key > 122 then char_key = 97 + char_key - 122 - 1
    end # - 1 because transition already occurs
    # puts char_key
    char_key.chr
  end
  .join('')
end

puts caesar_cipher("computer", 7)
puts 'z'.ord #122
puts 'a'.ord #97
