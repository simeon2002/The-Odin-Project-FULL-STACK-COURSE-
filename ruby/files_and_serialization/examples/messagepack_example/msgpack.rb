require 'msgpack'
msg = {:height => 47, :width => 32, :depth => 16}.to_msgpack

#prints out mumbo-jumbo
p msg

obj = MessagePack.unpack(msg)
p obj
