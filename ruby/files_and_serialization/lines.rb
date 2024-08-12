File.open('./lines.txt', 'r') do |file|
  p file.gets
  p file.gets
end #now it will be closed automatically as well!
