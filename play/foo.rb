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