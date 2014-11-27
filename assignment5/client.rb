require "xmlrpc/client"

server = XMLRPC::Client.new("172.28.173.246")
sum, difference =server.call("sample.sandy", 5, 3)
puts "sum: #{sum}, diff: #{difference}"

