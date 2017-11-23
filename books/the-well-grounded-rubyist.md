# lets read

## 语言基础




basic object

```
# ruby config

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
# global variables

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
# object_id

>> "foo".object_id == "foo".object_id
=> false
>> :foo.object_id == :foo.object_id
=> true
>> 1.object_id == 1.object_id
=> true
```

```
# send

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
# args *

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
# params

## without defaults

def foo(a:, b:)
  p a, b
end

>> foo(a: 1, b: 2)
1
2
=> [1, 2]

>> foo
ArgumentError: missing keywords: a, b
    from (irb):168:in `foo'
    from (irb):173
    from /Users/wendelu/.rbenv/versions/2.3.3/bin/irb:11:in `<main>'
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
    from (irb):150
    from /Users/wendelu/.rbenv/versions/2.3.3/bin/irb:11:in `<main>'
>> arr[0] << 'foo'
=> "afoo"
>> arr
=> ["afoo", "b", "c"]
```
```
# print format

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
# prepend

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
# class variables

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
# class instance variables

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
	from (irb):61:in `foo'
	from (irb):70
	from /Users/wendelu/.rbenv/versions/2.3.3/bin/irb:11:in `<main>'
```

```
➜  ruby -e 'p Kernel.private_instance_methods.sort'
[:Array, :Complex, :Float, :Hash, :Integer, :Rational, :String, :__callee__, :__dir__, :__method__, :`, :abort, :at_exit, :autoload, :autoload?, :binding, :block_given?, :caller, :caller_locations, :catch, :eval, :exec, :exit, :exit!, :fail, :fork, :format, :gem, :gem_original_require, :gets, :global_variables, :initialize_clone, :initialize_copy, :initialize_dup, :iterator?, :lambda, :load, :local_variables, :loop, :open, :p, :print, :printf, :proc, :putc, :puts, :raise, :rand, :readline, :readlines, :require, :require_relative, :respond_to_missing?, :select, :set_trace_func, :sleep, :spawn, :sprintf, :srand, :syscall, :system, :test, :throw, :trace_var, :trap, :untrace_var, :warn]
```

```
# condition

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
