require 'json'
content =  File.readlines("test.json")
content.each do |line|
  p line.strip()
end

p JSON.load File.read("test.json")
