require "xmlrpc/client"

server = XMLRPC::Client.new("localhost","/",8080)
result=server.call("sample.sandy", 5, 3)
sum=result["sum"]
difference=result["difference"]
puts "sum: #{sum}, diff: #{difference}"

