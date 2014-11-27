require “xmlrpc/client”
#make an object … server stub
server = XMLRPC::Client.new(“URL”, “path”)
#Call the remote server and get result
sum, difference =
server.call(“sample.sumAndDifference, 5, 3)
