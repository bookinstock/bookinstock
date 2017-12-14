require 'ostruct'

$a = 0

def start
  $a += 1
  OpenStruct.new(key: "start", value: $a)
end

def stop
  $a += 1
  OpenStruct.new(key: "stop", value: $a)
end

a = [stop, start, stop, start, start, stop, stop, start, start, start, stop, start]

# 2, 3, 4, 6, 8, 11


tmp = "stop"
b = []
a.each do |e|
  if e.key != tmp
    b << e
    tmp = e.key
  end
end
b.pop if b.last.key == 'start'

# >> pp b
# [#<OpenStruct key="start", value=2>,
#  #<OpenStruct key="stop", value=3>,
#  #<OpenStruct key="start", value=4>,
#  #<OpenStruct key="stop", value=6>,
#  #<OpenStruct key="start", value=8>,
#  #<OpenStruct key="stop", value=11>]


