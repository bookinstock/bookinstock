require 'socket'

# revised server
s = TCPServer.new(3939)
loop do
  conn = s.accept
  conn.puts "hi there"
  conn.puts "here is the date:"
  conn.puts `date`
  conn.close
end

# ➜  bookinstock git:(master) ruby play/foo.rb 

# ➜  bookinstock git:(master) ✗ telnet localhost 3939
# Trying ::1...
# telnet: connect to address ::1: Connection refused
# Trying 127.0.0.1...
# Connected to localhost.
# Escape character is '^]'.
# hi there
# here is the date:
# Fri  1 Dec 2017 07:46:50 CST
# Connection closed by foreign host.
