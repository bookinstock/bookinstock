# method more

class A
  def foo
    "foo in A"
  end
end

class B < A
  def foo
    "foo in B"
  end
end

class C < B
  def foo
    "foo in C"
  end
end

?> c = C.new
=> #<C:0x007faced021bc8>
>> c.foo
=> "foo in C"
>> unbind_b = B.instance_method(:foo)
=> #<UnboundMethod: B#foo>
>> unbind_b.bind(c).call
=> "foo in B"
>> unbind_a = A.instance_method(:foo)
=> #<UnboundMethod: A#foo>
>> unbind_a.bind(c).call
=> "foo in A"
