# class Lister < BasicObject
#   attr_reader :list

#   def initialize
#     @list = ""
#     @level = 0
#   end

#   def indent(string)
#     " " * @level + string.to_s
#   end

#   def method_missing(m, &block)
#     @list << indent(m) + ":"
#     @list << "\n"
#     if block
#       @level += 2
#       @list << indent(yield(self))
#       @level -= 2
#       @list << "\n"
#     end
#   end
# end

# lister = Lister.new
# lister.user do |user|
#   user.name { "wende lu" }
#   user.age { 25 }
#   user.family do |family|
#     family.mom do |mon|
#       mon.name { "fenhong zhu" }
#     end
#     family.dad do |dad|
#       dad.name { "zhuhong lu" }
#     end
#   end
# end


class A < BasicObject
  attr_reader :result

  def initialize
    @result = ""
    @indent_level = 0
  end

  def indent(str)
    "#{'  ' * @indent_level}#{str}\n"
  end

  def method_missing(str, &blk)
    @result << indent(str)
    if blk
      @indent_level += 1
      yield(self)
      @indent_level -= 1
      # yield(self)
    end
  end

  def inspect
    __id__
  end
end

a = A.new
a.me do |me|
  me.name { "wende" }
  me.age { 25 }
  me.mom do |mon|
    mon.name { "fen" }
  end
  me.dad do |dad|
    dad.name { "hong" }
  end
end

>> puts a.result
me
  name
  age
  mom
    name
  dad
    name
=> nil