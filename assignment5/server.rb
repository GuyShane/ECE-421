require "xmlrpc/server"
require "./Handler"

s=XMLRPC::Server.new(8080)
s.add_handler("sample",Handler.new)
s.serve
