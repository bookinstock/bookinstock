# The Well-Grounded Rubyist

## 第一部分：语言基础

```
# RUBY Config

>> RbConfig::CONFIG["bindir"]
=> "/Users/wendelu/.rbenv/versions/2.3.3/bin"
>> RbConfig::CONFIG["rubylibdir"]
=> "/Users/wendelu/.rbenv/versions/2.3.3/lib/ruby/2.3.0"
```

```
# RUBY

>> RUBY_VERSION
=> "2.3.3"
>> RUBY_PATCHLEVEL
=> 222
>> RUBY_RELEASE_DATE
=> "2016-11-21"
>> RUBY_REVISION
=> 56859
>> RUBY_COPYRIGHT
=> "ruby - Copyright (C) 1993-2016 Yukihiro Matsumoto"
>> RUBY_DESCRIPTION
=> "ruby 2.3.3p222 (2016-11-21 revision 56859) [x86_64-darwin15]"
```

```
# Global Variables

>> p $0 # file name
"irb"
=> "irb"
>> p $$ # process id
99207
=> 99207
>> p $: == $LOAD_PATH
true
=> true

require 'English'
check lib/ruby/2.3.0/English.rb
```

```
# Object#object_id

>> "foo".object_id == "foo".object_id
=> false
>> :foo.object_id == :foo.object_id
=> true
>> 1.object_id == 1.object_id
=> true
```

```
# Object#send

class A
  def foo
    "foo"
  end
end

>> a = A.new
=> #<A:0x007fa4a91f8df8>
>> a.send(:foo)
=> "foo"
>> a.__send__(:foo)
=> "foo"
>> a.public_send(:foo)
=> "foo"
```

```
# Args *

def foo(first, *args, last)
  p first, args, last
end

>> foo(1,2,3,4,5)
1
[2, 3, 4]
5
=> [1, [2, 3, 4], 5]
```

```
# Params

## Without defaults

def foo(a:, b:)
  p a, b
end

>> foo(a: 1, b: 2)
1
2
=> [1, 2]

>> foo
ArgumentError: missing keywords: a, b
>>

## with defaults

def bar(a: 1, b: 2)
  p a, b
end

>> bar(a: 3, b: 4)
3
4
=> [3, 4]

>> bar
1
2
=> [1, 2]

# double *

def bazz(a: 1, b: 2, **c)
  p a,b,c
end

>> bazz(a:11, b:22, c:33, d:44)
11
22
{:c=>33, :d=>44}
=> [11, 22, {:c=>33, :d=>44}]
```

```
# freeze

## string

>> a = "foo".freeze
=> "foo"
>> b = a.clone
=> "foo"
>> c = a.dup
=> "foo"
>> a.frozen?
=> true
>> b.frozen?
=> true
>> c.frozen?
=> false

## array

>> arr = %w[a b c].freeze
=> ["a", "b", "c"]
>> arr.frozen?
=> true
>> arr[0] = 'foo'
RuntimeError: can't modify frozen Array
>> arr[0] << 'foo'
=> "afoo"
>> arr
=> ["afoo", "b", "c"]
```
```
# Print Format

>> foo = 123.456
=> 123.456
>> p "#{"%.2f" % foo}"
"123.46"
=> "123.46"

%d -> digit
%f -> float
%s -> string
%x -> hex

ri sprintf
```

```
# Module#prepend

module M
  def hi
    super
    p ":)"
  end
end

class A
  prepend M

  def hi
    p "hi"
  end
end

>> A.new.hi
"hi"
":)"
=> ":)"
```

```
# Class Variables

class A
  @@foo = "bar"

  def self.ok
    @@foo
  end

  def hi
    @@foo
  end
end

class AA < A
end

>> A.ok
=> "bar"
>> A.new.hi
=> "bar"
>> AA.ok
=> "bar"
>> AA.new.hi
=> "bar"
```

```
# Class Instance Variables

class A
  @foo = "bar"

  def self.ok
    @foo
  end

  def hi
    @foo
  end
end

class AA < A
end

>> A.ok
=> "bar"
>> A.new.hi
=> nil
>> AA.ok
=> nil
>> AA.new.hi
=> nil
```

```
# protected

class A
  def foo(a)
    a.ok
  end

  protected

  def ok
    "ok"
  end
end

class B
  def foo(a)
    a.ok
  end
end

>> a = A.new
=> #<A:0x007fbb4182da58>
>> b = B.new
=> #<B:0x007fbb412b3140>
>> a.foo(a)
=> "aa"
>> b.foo(a)
NoMethodError: protected method `ok' called for #<A:0x007fef6d1aa7e8>
```

```
# ruby command options

➜  ruby -e 'p Kernel.private_instance_methods.sort'
[:Array, :Complex, :Float, :Hash, :Integer, :Rational, :String, :__callee__, :__dir__, :__method__, :`, :abort, :at_exit, :autoload, :autoload?, :binding, :block_given?, :caller, :caller_locations, :catch, :eval, :exec, :exit, :exit!, :fail, :fork, :format, :gem, :gem_original_require, :gets, :global_variables, :initialize_clone, :initialize_copy, :initialize_dup, :iterator?, :lambda, :load, :local_variables, :loop, :open, :p, :print, :printf, :proc, :putc, :puts, :raise, :rand, :readline, :readlines, :require, :require_relative, :respond_to_missing?, :select, :set_trace_func, :sleep, :spawn, :sprintf, :srand, :syscall, :system, :test, :throw, :trace_var, :trap, :untrace_var, :warn]
```

```
# Condition

a = 1 if false

if false
  b = 1
end

>> a
=> nil
>> b
=> nil
>> c
```

```
# Regex

>> n = /wende/.match("hi, zhaobo lu")
=> nil
>> m = /wende/.match("hi, wende lu")
=> #<MatchData "wende">
>> m.pre_match
=> "hi, "
>> m.post_match
=> " lu"
```

```
# ===

class A
end

class AA < A
end

>> A === A.new
=> true
>> AA === A.new
=> false
>> AA === A
=> false

>> (1..100) === 1
=> true
>> (1..100) === 0
=> false

>> /foo/ === "foobar"
=> true
```

```
# case

foo = "foo"

case foo
when /foo/
  "foo!"
when /bar/
  "bar!"
else
  "ok"
end

case foo
when "foo", "bar"
  "foobar"
when 'bazz'
  "bazz"
else
  "wtf"
end
```

```
# loop

i = 0
loop do
  p i += 1
  next if i == 5
  break if i == 10
end

def my_loop
  yield while true
end

i = 0
my_loop do
  p i += 1
  break if i == 5
end

1
2
3
4
5
```

```
# times

5.times { |i| p "hi, #{i}" }

class Integer
  def my_times
    i = 0
    until i == self
      yield(i)
      i += 1
    end
    self
  end
end

>> 5.my_times { |i| p "hi, #{i}" }
"hi, 0"
"hi, 1"
"hi, 2"
"hi, 3"
"hi, 4"
=> 5
```

```
# each

[1,2,3,4,5].each { |e| p e }

## v1
class Array
  def my_each
    i = 0
    until i == length
      yield(self[i])
      i += 1
    end
    self
  end
end

## v2
class Array
  def my_each
    size.times do |i|
      yield(self[i])
    end
    self
  end
end

>> [1,2,3,4,5].my_each { |e| p e }
1
2
3
4
5
=> [1, 2, 3, 4, 5]
```

```
# map

[1,2,3,4,5].map { |e| e.to_s }

## v1
class Array
  def my_map
    i = 0
    acc = []
    until i == length
      acc << yield(self[i])
      i += 1
    end
    acc
  end
end

## v2
class Array
  def my_map
    acc = []
    each do |e|
      acc << yield(e)
    end
    acc
  end
end

>> [1,2,3,4,5].my_map { |e| e.to_s }
=> ["1", "2", "3", "4", "5"]
```

```
# Block Args

def foo
  yield(1, 2, 3, 4, 5)
end

>> foo { |a, b=1, *c, d| p a,b,c,d }
1
2
[3, 4]
5
=> [1, 2, [3, 4], 5]
```

```
# Closure

def foo
  x = 1
  [1,2,3].each do |x|
    p x += 10
  end
  p x
end

>> foo
11
12
13
1
=> 1
```

```
# Closure more

def foo
  x = "foo"
  3.times do |i|
    x = i
    p x
  end
  p x
end

>> foo
0
1
2
2
=> 2

def bar
  x = "bar"
  3.times do |i; x|
    x = i
    p x
  end
  p x
end

>> bar
0
1
2
"bar"
```

```
# Exception

def foo
  raise 'wtf'
rescue => e
  p e.class
  p e.message
  p e.backtrace
end

>> foo
RuntimeError
"wtf"
[
  "(irb):67:in `foo'",
  "(irb):71:in `irb_binding'",
  ...
]
```

```
# Exception more

def foo
  fh = File.open(filename)
rescue => e
  logfile.puts("try to open #{filename}, #{Time.now}")
  logfile.puts("exception: #{e.message}")
  raise # raise again
end
```

## 第二部分：内之类和模块

```
# Sugar

class A
  def [](idx)
    foo[idx]
  end

  def []=(idx, val)
    foo[idx] = val
  end

  def <<(val)
    foo << val
  end

  def foo
    @foo ||= []
  end
end

>> a = A.new
=> #<A:0x007fa801921638>
>> a << 1 << 2
=> [1, 2]
>> a[0]
=> 1
>> a[0] = "ok"
=> "ok"
>> a.foo
=> ["ok", 2]
```

```
# Sugar more

class A
  def +@
    foo << "ok"
  end

  def -@
    foo.tap(&:pop)
  end

  def !
    foo.reverse!
  end

  def foo
    @foo ||= []
  end
end

>> a = A.new
=> #<A:0x007fa803216648>
>> +a
=> ["ok"]
>> +a
=> ["ok", "ok"]
>> +a
=> ["ok", "ok", "ok"]
>> -a
=> ["ok", "ok"]
>> a.foo << "bar"
=> ["ok", "ok", "bar"]
>> !a
=> ["bar", "ok", "ok"]
>> not a
=> ["ok", "ok", "bar"]
```

```
# Object string format

class A
  def to_s
    "to_s"
  end

  def inspect
    "inspect"
  end
end

>> a = A.new
=> inspect
>> puts a
to_s
=> nil
>> p a
inspect
=> inspect
```

```
# Splat

>> foo = [1,2,3,4,5]
=> [1, 2, 3, 4, 5]
>> bar = [*foo]
=> [1, 2, 3, 4, 5]
>> bazz = [foo]
=> [[1, 2, 3, 4, 5]]
```

```
# to integer

>> "foo".to_i
=> 0
>> "123foo".to_i
=> 123
>> Integer("123foo")
ArgumentError: invalid value for Integer(): "123foo"

# to float

>> "foo".to_f
=> 0.0
>> "1.23foo".to_f
=> 1.23
>> Float("1.23foo")
ArgumentError: invalid value for Float(): "1.23foo"
```

```
# to_str

class A
  def name
    @name ||= "wende"
  end
end

>> "hi" + A.new
TypeError: no implicit conversion of A into String

class A
  def to_str
    name
  end
end

>> "hi" + A.new
=> "hiwende"
>> "hello" << A.new
=> "hellowende"
```

```
# to_ary

class A
  def name
    @name ||= "wende"
  end
end

>> [1,2,3] + A.new
TypeError: no implicit conversion of A into Array

class A
  def to_ary
    [name]
  end
end

>> [1,2,3] + A.new
=> [1, 2, 3, "wende"]
>> [1,2,2].concat(A.new)
=> [1, 2, 2, "wende"]
```

```
# Comparable

class A
  include Comparable

  attr_accessor :name, :age

  def initialize(name:, age:)
    @name = name
    @age = age
  end

  def <=>(a)
    age <=> a.age
  end
end

>> a1 = A.new(name: 'foo', age: 18)
=> #<A:0x007f8f7a905a68 @name="foo", @age=18>
>> a2 = A.new(name: 'bar', age: 19)
=> #<A:0x007f8f7a8f4808 @name="bar", @age=19>
>> a3 = A.new(name: 'bar', age: 20)
=> #<A:0x007f8f7a8df2c8 @name="bar", @age=20>
>> a2.between?(a1, a3)
=> true
```

```
# Inspection

obj.methods
obj.public_methods
obj.protected_methods
obj.private_methods
obj.singleton_methods

Klass.public_instance_methods
Klass.protected_instance_methods
Klass.private_instance_methods
```

```
# String

a = "foo"
b = 'bar'
c = %q(abc def)
d = %Q(abc #{666})
e = <<SQL
  SELECT * FROM USERS
  WHERE users.name = "wende";
SQL

>> a = "hifoobar"
=> "hifoobar"
>> a["foo"] = "ok"
=> "ok"
>> a[-3..-1] = "bazz"
=> "bazz"
>> a
=> "hiokbazz"

>> "abcfoodef".include?("foo")
=> true
>> "abcfoodef".start_with?("abc")
=> true
>> "abcfoodef".end_with?("def")
=> true
>> "abcfoodef".empty?
=> false

>> "abcabc".size
=> 6
>> "abcabc".length
=> 6
>> "abcabc".count('a')
=> 2
>> "abcabc".count('ab')
=> 4
>> "abcabc".count('a-c')
=> 6
>> "abcabc".count('a-c', '^b')
=> 4
>> "abcabc".count('^b-c')
=> 2

>> "abcabc".index("b")
=> 1
>> "abcabc".rindex("b")
=> 4

>> "a".ord
=> 97
>> "A".ord
=> 65
>> 97.chr
=> "a"
>> 65.chr
=> "A"

>> "aBc".upcase
=> "ABC"
>> "aBc".downcase
=> "abc"
>> "aBc".swapcase
=> "AbC"

>> "aaaaa".ljust(10)
=> "aaaaa     "
>> "aaaaa".rjust(10)
=> "     aaaaa"
>> "aaaaa".ljust(10, '>')
=> "aaaaa>>>>>"
>> "aaaaa".rjust(10, '<')
=> "<<<<<aaaaa"

>> "aaa".chop
=> "aa"
>> "aaa".chop.chop
=> "a"
>> "aaa".chomp
=> "aaa"
>> "aaa".chomp("a")
=> "aa"
>> "aaa\n".chomp
=> "aaa"

>> "abc".clear
=> ""
>> "abc".replace("foo")
=> "foo"
>> "abc".delete("a")
=> "bc"
>> "abc".delete("^a")
=> "a"
>> "abc".delete("a-b")
=> "c"
>> "abcd".delete("a-c", '^b')
=> "bd"

>> "foo".crypt("ab")
=> "abQ9KY.KfrYrc"

>> "foo".next
=> "fop"
>> "foo".succ
=> "fop"

>> "10".to_i(2)
=> 2
>> "10".to_i(10)
=> 10
>> "10".to_i(16)
=> 16
>> "10".oct
=> 8
>> "10".hex
=> 16

>> __ENCODING__
=> UTF-8
>> "foo".encoding
=> #<Encoding:UTF-8>
>> "bar".encode("US-ASCII")
=> "bar"
>> "bar".encode!("US-ASCII")
=> "bar"
```

```
# Symbol

>> Symbol.all_symbols.size
=> 3566
>> ok = 1
=> 1
>> Symbol.all_symbols.grep(/^ok/)
=> [:ok]

>> :aBc.upcase
=> :ABC
>> :aBc.downcase
=> :abc
>> :aBc.swapcase
=> :AbC
>> :aBc.next
=> :aBd
>> :aBc.succ
=> :aBd
>> :aBc[-1]
=> "c"
>> :abc.casecmp(:aaa)
=> 1
```

```
# Numeric

>> rand(100)
=> 28

>> 99.4.round
=> 99
>> 99.5.round
=> 100

>> 010
=> 8
>> 0x10
=> 16
>> 0.zero?
=> true
```

```
# date & time

require 'time'
add Time

require 'date'
add Date
add DateTime

>> Time.now
=> 2017-11-25 19:15:21 +0800
>> Time.new
=> 2017-11-25 19:15:32 +0800
>> Time.now.to_i
=> 1511608558
>> Time.at(1511608558)
=> 2017-11-25 19:15:58 +0800
>> Time.mktime(1991,10,25,10,30,30)
=> 1991-10-25 10:30:30 +0800
>> Time.local(1991,10,25,10,30,30)
=> 1991-10-25 10:30:30 +0800
>> Time.parse('oct 25 1991 10:30:59')
=> 1991-10-25 10:30:59 +0800

>> Date.today
=> #<Date: 2017-11-25 ((2458083j,0s,0n),+0s,2299161j)>
>> Date.new(1991,10,25)
=> #<Date: 1991-10-25 ((2448555j,0s,0n),+0s,2299161j)>
>> Date.civil(1991,10,25)
=> #<Date: 1991-10-25 ((2448555j,0s,0n),+0s,2299161j)>
>> Date.parse('1991/10/25')
=> #<Date: 1991-10-25 ((2448555j,0s,0n),+0s,2299161j)>
>> Date.parse('1991-10-25')
=> #<Date: 1991-10-25 ((2448555j,0s,0n),+0s,2299161j)>
>> Date.parse('October 25 1991')
=> #<Date: 1991-10-25 ((2448555j,0s,0n),+0s,2299161j)>
>> Date.parse('25 oct 1991')
=> #<Date: 1991-10-25 ((2448555j,0s,0n),+0s,2299161j)>

>> DateTime.now
=> #<DateTime: 2017-11-25T19:18:52+08:00 ((2458083j,40732s,871820000n),+28800s,2299161j)>
>> DateTime.new(1991,10,25,10,30,59)
=> #<DateTime: 1991-10-25T10:30:59+00:00 ((2448555j,37859s,0n),+0s,2299161j)>
>> DateTime.civil(1991,10,25,10,30,59)
=> #<DateTime: 1991-10-25T10:30:59+00:00 ((2448555j,37859s,0n),+0s,2299161j)>
>> DateTime.parse('oct 25 1991 10:30:59')
=> #<DateTime: 1991-10-25T10:30:59+00:00 ((2448555j,37859s,0n),+0s,2299161j)>

>> dt.year
=> 1991
>> dt.month
=> 10
>> dt.day
=> 25
>> dt.hour
=> 10
>> dt.minute # min
=> 30
>> dt.second # sec
=> 59
>> dt.sunday?
=> false
>> dt.leap?
=> false

>> dt.to_s
=> "1991-10-25T10:30:59+00:00"
>> dt.strftime("%m-%d-%y")
=> "10-25-91"
>> dt.strftime("%Y %b %d %a")
=> "1991 Oct 25 Fri"
>> dt.strftime("%Y %B %d %A")
=> "1991 October 25 Friday"
>> dt.strftime("%B %d %Y")
=> "October 25 1991"
>> dt.strftime("%H:%M:%S")
=> "10:30:59"
>> dt.strftime("%c")
=> "Fri Oct 25 10:30:59 1991"
>> dt.strftime("%x")
=> "10/25/91"

>> dt >> 1
=> #<DateTime: 1991-11-25T10:30:59+00:00 ((2448586j,37859s,0n),+0s,2299161j)>
>> dt << 1
=> #<DateTime: 1991-09-25T10:30:59+00:00 ((2448525j,37859s,0n),+0s,2299161j)>
>> dt.next_day
=> #<DateTime: 1991-10-26T10:30:59+00:00 ((2448556j,37859s,0n),+0s,2299161j)>
>> dt.prev_day
=> #<DateTime: 1991-10-24T10:30:59+00:00 ((2448554j,37859s,0n),+0s,2299161j)>
>> dt.next_day(3)
=> #<DateTime: 1991-10-28T10:30:59+00:00 ((2448558j,37859s,0n),+0s,2299161j)>

>> d = Date.today
=> #<Date: 2017-11-25 ((2458083j,0s,0n),+0s,2299161j)>
>> next_week = d + 7
=> #<Date: 2017-12-02 ((2458090j,0s,0n),+0s,2299161j)>
>> d.upto(next_week) { |date| puts "#{date} is a #{date.strftime("%A")}" }
2017-11-25 is a Saturday
2017-11-26 is a Sunday
2017-11-27 is a Monday
2017-11-28 is a Tuesday
2017-11-29 is a Wednesday
2017-11-30 is a Thursday
2017-12-01 is a Friday
2017-12-02 is a Saturday
=> #<Date: 2017-11-25 ((2458083j,0s,0n),+0s,2299161j)>

ri Date
```

```
# try_convert

Array.try_convert(obj)  # to_ary
Hash.try_convert(obj)   # to_hash
String.try_convert(obj) # to_str
Regexp.try_convert(obj) # to_regexp
IO.try_convert(obj)     # to_io
```

```
# Array

>> Array.new(3)
=> [nil, nil, nil]
>> Array.new(3, "foo")
=> ["foo", "foo", "foo"]
>> Array.new(3) { |n| n + 1 }
=> [1, 2, 3]

>> %w[a b c]
=> ["a", "b", "c"]
>> %i[a b c]
=> [:a, :b, :c]
>> %W[#{1+1} #{2+2}]
=> ["2", "4"]
>> %I[#{1+1} #{2+2}]
=> [:"2", :"4"]

class A
  def to_ary
    ["ok"]
  end

  def to_a
    ["foo", "bar"]
  end
end
>> Array(A.new)
=> ["ok"]

class B
  def to_a
    ["foo", "bar"]
  end
end
>> Array(B.new)
=> ["foo", "bar"]

>> arr = ["foo", "bar", "bazz"]
=> ["foo", "bar", "bazz"]
>> arr[0,2]
=> ["foo", "bar"]
>> arr.slice(0, 2)
=> ["foo", "bar"]
>> arr.values_at(0, 2)
=> ["foo", "bazz"]

>> a = ["a", "b", "c"]
=> ["a", "b", "c"]
>> a.unshift("foo")
=> ["foo", "a", "b", "c"]
>> a.shift
=> "foo"

>> a
=> ["a", "b", "c"]
>> a.push("bar")
=> ["a", "b", "c", "bar"]
>> a.pop
=> "bar"
>> a
=> ["a", "b", "c"]

>> a = %w[a b c d e f]
=> ["a", "b", "c", "d", "e", "f"]
>> a.shift(2)
=> ["a", "b"]
>> a.pop(2)
=> ["e", "f"]
>> a
=> ["c", "d"]

>> a.replace(["c","b","a"])
=> ["c", "b", "a"]
>> a.clear
=> []

>> [1, [2, 3], [4, [5, 6]]].flatten
=> [1, 2, 3, 4, 5, 6]
>> [1, [2, 3], [4, [5, 6]]].flatten(1)
=> [1, 2, 3, 4, [5, 6]]

>> [1, 2, 3].reverse
=> [3, 2, 1]

>> [1, 2, 3].join('-')
=> "1-2-3"
>> [1, 2, 3] * '-'
=> "1-2-3"

>> [1, 2, 3, 1, 2].uniq # compare with ==
=> [1, 2, 3]

>> [1, nil, 2, nil, 3].compact
=> [1, 2, 3]

>> [1, 2, 3, 4, 5].size
=> 5
>> [1, 2, 3, 4, 5].length
=> 5
>> [1, 2, 3, 4, 5].count { |e| e > 3 }
=> 2
>> [1, 2, 3, 4, 5].empty?
=> false
>> [1, 2, 3, 4, 5].include? 2
=> true

>> [1, 2, 3, 4, 5].first 2
=> [1, 2]
>> [1, 2, 3, 4, 5].last 2
=> [4, 5]
>> [1, 2, 3, 4, 5].sample 2
=> [3, 1]

>> [1 ,2 ,3] | [2, 3, 4]
=> [1, 2, 3, 4]
>> [1, 2, 3] & [2, 3, 4]
=> [2, 3]

>> [1, 1, 2] | [2, 2, 3]
=> [1, 2, 3]
>> [1, 1, 2] & [2, 2, 3]
=> [2]
```

```
# Hash

foo = { a: 1, b: 2, c: 3 }
foo.each.with_index do |(key, value), idx|
  puts "#{idx}: #{key} => #{value}"
end

0: a => 1
1: b => 2
2: c => 3
=> {:a=>1, :b=>2, :c=>3}

>> foo = { a: 1, b: 2, c: 3 }
=> {:a=>1, :b=>2, :c=>3}
>> foo[:a] = "fff"
=> "fff"
>> foo.store(:b, "bbb")
=> "bbb"
>> foo
=> {:a=>"fff", :b=>"bbb", :c=>3}

>> foo = { a: 1, b: 2, c: 3 }
=> {:a=>1, :b=>2, :c=>3}
>> foo.fetch(:ok, "unknown")
=> "unknown"
>> foo
=> {:a=>1, :b=>2, :c=>3}
>> foo.values_at(:a, :b, :ok)
=> [1, 2, nil]

>> foo = { a: 1, b: 2, c: 3 }
=> {:a=>1, :b=>2, :c=>3}
>> foo.update(a: "a", b: "b") # bang!
=> {:a=>"a", :b=>"b", :c=>3}
>> foo.merge(a: "aa", b: "bb")
=> {:a=>"aa", :b=>"bb", :c=>3}
>> foo
=> {:a=>"a", :b=>"b", :c=>3}

>> foo = { a: 1, b: 2, c: 3 }
=> {:a=>1, :b=>2, :c=>3}
>> foo.select { |k,v| v > 2 }
=> {:c=>3}
>> foo.reject { |k,v| v > 2 }
=> {:a=>1, :b=>2}
>> foo.select! { |k,v| v > 2 } # bang! same as :keep_if
>> foo.reject! { |k,v| v > 2 } # bang! same as :delete_if

>> foo = { a: 1, b: 2, c: 3 }
=> {:a=>1, :b=>2, :c=>3}
>> foo.invert
=> {1=>:a, 2=>:b, 3=>:c}

>> foo.clear
=> {}
>> foo.replace(a: 'a', b: 'b')
=> {:a=>"a", :b=>"b"}
```

```
# Range

>> a = 1..10
=> 1..10
>> a.include? 1
=> true
>> a.include? 10
=> true

>> b = 1...10
=> 1...10
>> b.include? 1
=> true
>> b.include? 10
=> false

>> b.begin
=> 1
>> b.end
=> 10
>> b.exclude_end?
=> true

>> b.include? 10
=> false
>> b.cover? 9
=> true

>> c = 'a'..'z'
=> "a".."z"
>> c.include? 'bcd'
=> false
>> c.cover? 'bcd'
=> true
>> (1.0..2.0).include? 1.5
=> true
```

```
# Set

require 'set'

>> foo = ['a', 'b', 'c']
=> ["a", "b", "c"]
>> set = Set.new(foo)
=> #<Set: {"a", "b", "c"}>

>> set << "d"
=> #<Set: {"a", "b", "c", "d"}>
>> set << "d"
=> #<Set: {"a", "b", "c", "d"}>
>> set.add "d"
=> #<Set: {"a", "b", "c", "d"}>
>> set.add? "d"
=> nil
>> set.delete("d")
=> #<Set: {"a", "b", "c"}>

## union + , |
## intersetction &
## difference -

>> set_1 = Set.new([1, 2, 3])
=> #<Set: {1, 2, 3}>
>> set_2 = Set.new([2, 3, 4])
=> #<Set: {2, 3, 4}>
>> set_1 + set_2
=> #<Set: {1, 2, 3, 4}>
>> set_1 | set_2
=> #<Set: {1, 2, 3, 4}>
>> set_1 & set_2
=> #<Set: {2, 3}>
>> set_1 - set_2
=> #<Set: {1}>
>> set_1 ^ set_2
=> #<Set: {4, 1}>

>> a
=> [1, 2, 3]
>> b
=> {:a=>3, :b=>4}
>> a.to_set.merge(b.values)
=> #<Set: {1, 2, 3, 4}>

>> set_1 = Set.new([1, 2, 3])
=> #<Set: {1, 2, 3}>
>> set_2 = Set.new([2, 3])
=> #<Set: {2, 3}>
>> set_1.superset? set_2
=> true
>> set_2.subset? set_1
=> true
>> set_1.proper_superset? set_2
=> true
>> set_2.proper_subset? set_1
=> true
```

```
# Enumerable

enum = 1..3
>> enum.include? 2
=> true
>> enum.all? {|e| e.odd?}
=> false
>> enum.any? {|e| e.odd?}
=> true
>> enum.one? {|e| e.even?}
=> true
>> enum.none? {|e| e.even?}
=> false

>> enum.find {|e| e==2}
=> 2
>> enum.find(->{"ok"}) {|e| e==10}
=> "ok"

## grep -> ===
>> ['ab', 'bb', 'ac'].grep(/a/)
=> ["ab", "ac"]
>> [1, 2, 3, 4, 5, 6].grep(3..5)
=> [3, 4, 5]
>> [1, 2, '3', 4, '5'].grep(String)
=> ["3", "5"]

>> [1, 2, 3, 4, 5].group_by {|e| e.odd?}
=> {true=>[1, 3, 5], false=>[2, 4]}
>> [1, 2, 3, 4, 5].partition {|e| e.odd?}
=> [[1, 3, 5], [2, 4]]

>> a = [1, 2, 3, 4, 5]
=> [1, 2, 3, 4, 5]
>> a.first
=> 1
>> a.first(2)
=> [1, 2]
>> a.take(2)
=> [1, 2]
>> a.drop(2)
=> [3, 4, 5]

>> [1, 2, 3].min
=> 1
>> [1, 2, 3].max
=> 3
>> [1, 2, 3].minmax
=> [1, 3]
>> [-1, 2, 3].max_by {|e| -e}
=> 1
>> [-1, 2, 3].min_by {|e| -e}
=> 3
>> [1, 2, 3].minmax_by {|e| -e}
=> [3, 1]

>> [1, 2, 3].reverse_each {|e| p e}
>> [1, 2, 3].each_with_index {|e,i| p e,i}
>> {a:1, b:2}.each_with_index {|(k,v),i| p k,v,i}

>> (1..6).each_slice(2) {|e| p e}
[1, 2]
[3, 4]
[5, 6]
=> nil
>> (1..6).each_cons(2) {|e| p e}
[1, 2]
[2, 3]
[3, 4]
[4, 5]
[5, 6]
=> nil
>> (1..5).each_slice(2) {|e| p e}
[1, 2]
[3, 4]
[5]
=> nil

>> (1..3).cycle(2) {|e| p e}
1
2
3
1
2
3
=> nil

>> (1..3).inject(0) {|acc, e| acc + e} # reduce
=> 6
>> (1..3).map {|e| e + 1} # collect
=> [2, 3, 4]

>> 'abc'.each_char {|e| p e}
>> 'abc'.each_byte {|e| p e}
>> "ab\ncd\neee".each_line {|e| p e}

>> [1,"3",2,"6","5",4].sort {|a,b| a.to_i <=> b.to_i}
=> [1, 2, "3", 4, "5", "6"]
>> [1,"3",2,"6","5",4].sort_by {|e| e.to_i}
=> [1, 2, "3", 4, "5", "6"]
```

```
# Enumerator

e_1 = Enumerator.new do |y|
  y << 1
  y << 2
  y << 3
end
>> e_1.map(&:to_i)
=> [1, 2, 3]

e_2 = Enumerator.new do |y|
  y.yield 1
  y.yield 2
  y.yield 3
end
>> e_2.map(&:to_i)
=> [1, 2, 3]

>> [1, 2, 3].enum_for(:select)
=> #<Enumerator: [1, 2, 3]:select>
>> [1, 2, 3].to_enum(:select)
=> #<Enumerator: [1, 2, 3]:select>
>> [1, 2, 3].select
=> #<Enumerator: [1, 2, 3]:select>

>> en = [1, 2, 3].to_enum(:inject, 0)
=> #<Enumerator: [1, 2, 3]:inject(0)>
>> en.each {|a, e| a + e}
=> 6

>> [1, 2, 3].to_enum
=> #<Enumerator: [1, 2, 3]:each>
>> { a: 1, b: 2 }.to_enum
=> #<Enumerator: {:a=>1, :b=>2}:each>

>> e = [1, 2, 3].to_enum
=> #<Enumerator: [1, 2, 3]:each>
>> e.next
=> 1
>> e.next
=> 2
>> e.next
=> 3
>> e.next
StopIteration: iteration reached an end

module Music
  class Scale
    NOTES = %w[c c# d d#]

    def play
      NOTES.each { |note| yield note }
    end
  end
end
?> scale = Music::Scale.new
=> #<Music::Scale:0x007ff784019338>
>> enum = scale.enum_for(:play)
=> #<Enumerator: #<Music::Scale:0x007ff784019338>:play>
>> enum.map(&:upcase)
=> ["C", "C#", "D", "D#"]

>> a = [1, 2, 3, 4]
=> [1, 2, 3, 4]
>> a.each_slice(2)
=> #<Enumerator: [1, 2, 3, 4]:each_slice(2)>
>> a.each_slice(2) {|a| p a}
[1, 2]
[3, 4]
=> nil
>> a.each_slice(2).map {|first, second| "#{first}-#{second}"}
=> ["1-2", "3-4"]
>> a.select.with_index {|e, i| i.odd?}
=> [2, 4]
>> a.map.with_index {|e, i| [e, i]}
=> [[1, 0], [2, 1], [3, 2], [4, 3]]
```

```
# XOR

>> 123 ^ 111
=> 20
>> 123 ^ 111 ^ 111
=> 123
>> 123 ^ 111 ^ 123
=> 111

class String
  def ^(key)
    kenum = key.each_byte.cycle
    str = each_byte.map {|byte| byte ^ kenum.next}.pack("C*")
    str.force_encoding(self.encoding)
  end
end
>> "abc" ^ "wtf"
=> "\x16\x16\x05"
>> "abc" ^ "wtf" ^ "wtf"
=> "abc"
```

```
# lazy

>> (1..Float::INFINITY).lazy
=> #<Enumerator::Lazy: 1..Infinity>
>> (1..Float::INFINITY).lazy.select {|e| e % 3 == 0}
=> #<Enumerator::Lazy: #<Enumerator::Lazy: 1..Infinity>:select>
>> (1..Float::INFINITY).lazy.select {|e| e % 3 == 0}.first(5)
=> [3, 6, 9, 12, 15]
>> (1..Float::INFINITY).lazy.select {|e| e % 3 == 0}.take(5).force
=> [3, 6, 9, 12, 15]
```

```
# Regex
```

## 第三部分：动态编程

```
# basic object
```