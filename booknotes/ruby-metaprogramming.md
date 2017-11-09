# 《Ruby 元编程》

## Ruby 篇

## 第1章：元 这个字眼

### 什么是元编程？

> Metaprogramming is writing code that writes code during runtime to make your life easier.

定义：元编程是编写能生成代码的代码。

正规定义：元编程是编写在运行时操作语言构件的代码。

我们可以在运行时访问类的元数据，或是动态的生成新的类和方法。

## 第2章：星期一：对象模型

### 打开类（Open Class）

打开某个已经存在的类做修改，标准库中的类也不例外。

打开类又叫猴子补丁，注意不要覆盖了已有的方法，影响其他代码。

使用细化 refinement 可以确保猴子补丁只在特定的作用域中有效，提高安全性。

元编程是把双刃剑，他可能带给你奇效，也可带给你毁灭，如何控制他要看使用者本身的功力。

> “With great power comes great responsibility.” - Uncle Ben

### 类和对象

一个对象的实例变量存放在对象本身中，而一个对象的方法存放在对象自身的类中。

这就是同一个类的对象共享同样的方法但不共享实例变量的原因。

对象是一组实例变量外加一个指向其类的引用。

类是一个对象外加一组实例方法和一个对其超类的引用。

class 关键字更像是一个作用域操作符，把你带到类的上下文中。

### 类和模块

所有类都是从 Class 实例化而来的。

所有模块都是从 Module 实例化而来的。

Class 是 Module 的子类，所以一个类也是一个模块。

类是增强版的模块，拥有三个特有的方法 (:allocate, :new, :superclass).

类和模块而这个概念十分相似，区分二者可以让代码更清晰，意图更明显。

何时使用模块：希望把代码引入其他类或模块中；创建命名空间。

何时使用类：希望代码可以实例化对象，或被继承。

### 常量

首字母大写的都是常量。

常量的作用域类似于文件系统的目录，通过 `::` 进行分割。

默认直接以 `::` 开头表示最外层常量，类似于 `\` 表示根目录。

`Module#constants` 返回当前范围内的所有常量，类似于 `ls`。

`Module.constants` 返回当前程序中所有最外层的常量。

`Module.nesting` 可以查看当前代码所在路径。

### load & require

`load` 加载代码执行脚本，防止常量被污染使用 `load('file.rb', true)` 来创建临时的命名空间。

`require` 导入类库，不会创建临时的命名空间，相比于`load` 导入只会执行一次。

`require_relative` 导入时看做当前路径。

### 方法查找

方法查找：找到这个方法在哪？

查找规则：向右一步，再向上。

向右一步：找到接收者（对象）的类。

再向上：查看这个类的继承链中是否有该方法。

若找不到则调用接收者的 `method_missing` 方法，重跑 ‘向右一步，再向上’。

`Module#ancestors` 查看类或模块的祖先链。

`Module#include` 将模块插入当前类或模块的上方（用来引入某个附加功能）。

`Module#prepend` 将模块插入当前类或模块的下方（可用来重写当前类的方法）。

### Kernel 模块

内核方法：在 `Kernel` 模块中定义的方法。

因为在 `Object` 引入了 `Kernel` 模块，所以几乎所有类的对象都可以调用内行人方法。

所以 `print` 这样像关键字一样的方法其实都是内核方法。

### Self

调用一个方法时，接受者会扮演 `self` 角色。

定义一个类或模块时，该类或模块会扮演 `self` 角色。

### private

规则1：如果调用方法的接收者不是自己，那么必须明确指明接收者。

规则2：私有方法只能通过隐式的接收者调用。

由规则1，2可得出：只能在自身中调用私有方法。

### Access Control

public 方法可以再任何地方被调用。

private 方法只能在类内部被隐式调用。

protected 方法只能在类内部被调用，可显式调用。

`Object.send` 可打破以上规则，调用任何方法。

## 第3章：星期二：方法

解决代码繁复的问题。

### Dynamic Dispatch

在运行时动态调用方法。

`Object#send` 动态的调用，将方法名作为参数传入。

`Object#public_send` 动态调用，只调用共有方法。

### Dynamic Method

在运行时动态创建方法。

`Module#define_method` 动态定义，将方法名作为参数传入。

### Method Missing

他是 `BasicObject` 的私有方法，默认抛出 `NoMethodError`.

别人如果问一些不存在的东西，就这样做。



https://relishapp.com/womply/ruby-style-guide/docs/metaprogramming

http://yehudakatz.com/2009/11/15/metaprogramming-in-ruby-its-all-about-the-self/

# Singleton Class
普通对象的单件类
类对象的单件类

# Method
```
mod.instance_methods(include_super=true) -> array            # public and protected 

mod.public_instance_methods(include_super=true) -> array     # public instance methods

mod.protected_instance_methods(include_super=true) -> array  # protected instance methods

mod.private_instance_methods(include_super=true) -> array    # private instance methods

const_defined?(sym, inherit=true) -> true/false
```

# Equality
```ruby
object == other       # check same object, should be overridden by subclasses  
object.equal?(other)  # check same object, should not be overridden by subclasses
object.eql?(other)    # returns true if obj and other refer to the same hash key
mod === object        # returns true if obj is an instance of mod or and instance of one of mod’s descendants
```

# Class Variable and Instance Variable
@instance_varialbe 存在于实例对象的内部，只有用到时才会初始化。
@instance_class_varialbe 只在定义的类中存在，仅有类方法可以访问。
@@class_variable 存在于定义的类及其子类中，实例方法和类方法都可以访问。
```ruby
obj.instance_variables              -> array
obj.instance_variable_get(sym)      -> obj
obj.instance_variable_set(sym, obj) -> obj
obj.instance_variable_defined?(sym) -> true/false

mod.class_variables(inherit=true)   -> array
mod.class_variables_get(sym)        -> obj
mod.class_variables_set(sym, obj)   -> obj
mod.class_variables_defined?(sym)   -> true/false
```

# Related methods
obj.methods 返回所有该对象可调用的非私有方法，false 只返回单件类方法。
obj.public_methods 返回所有公有方法，false 只返回该对象所属类和单件类中的公有方法。
obj.protected_methods 返回所有被保护方法，false 只返回该对象所属类和单件类中的被保护方法。
obj.private_methods 返回所有私有方法，false 只返回该对象所属类和单件类中的私有方法。
obj.public_method(sym) 返回查找到的 Method 对象，若搜索不到则抛出异常。
obj.singleton_methods(all=true) 返回该对象的单件类方法，false 不包含添加的模块的方法。

class.ancestors
class.superclass
class.class
obj.send
obj.public_send
module.define_method

extend
module M123; def m123; end end
k.extend M123
k.methods(false)   #=> [:singleton_method]

1. singleton class and methods
2. define methods use instance_eval and class_eval
  Developer.instance_eval # create class methods (singleton methods of the class)
  Developer.class_eval # create instance methods
3. define missing methods on fly
  when you call a method on an object, ruby first go to its class and broswer all instance methods,
  if it doesn't find the method there, it continues search up the ancestors chain. 
  if still not found, call method_missing
method_missing an instance method of the BasicObject which that every object inherits

4. Module#define_method create methods dynamically
  use define_method and method_missing to do some tricks
5. send

use metaprogramming in testing to mock methods and objects
method_missing
instance_eval
class_eva


proc lambda
define_method => define instance method
define_singleton_method => define class method
send
method_missing
binding

[1] pry(main)> a = [1,2,3,4]
=> [1, 2, 3, 4]
[2] pry(main)> a.inject(0,:+)
=> 10

topics:
Module#included
Module#class_eval
Object#instance_eval
Struct

meta resources
Metaprogramming Ruby
Rails Antipatterns
[Metaprogramming Ruby and Rails Antipatterns]( http://eewang.github.io/blog/2013/04/29/metaprogramming-ruby-and-antipatterns-in-rails/)
http://eewang.github.io/blog/2013/04/29/metaprogramming-ruby-and-antipatterns-in-rails/
http://eewang.github.io/blog/2013/05/17/metaprogramming-ruby-and-rails-antipatterns-part-2-of-2/
https://robots.thoughtbot.com/writing-a-domain-specific-language-in-ruby

https://robots.thoughtbot.com/writing-a-domain-specific-language-in-ruby
https://github.com/geetarista/ruby-metaprogramming
https://github.com/tutsplus/ruby-metaprogramming-exercise
http://ruby-metaprogramming.rubylearning.com/ # for more study

1. dynamic programming 
  eval
  instance_eval
  class_eval (aka: module_eval)
  class_variable_set
  class_variable_get
  class_variables (Try it out: instance_variables)
  instance_variable_set (Try it out: instance_variable_get)
  define_method
  const_set
  const_get (Try it out: constants)
  Class.new (Try it out: Struct.new)
  binding (Try it out: lambda)
  send (Try it out: method)
  remove_method
  undef_method
  method_missing

2. meta class / singleton class
  class << self; self; end

3. hook methods
  include
  extend
  included
  extended

http://eewang.github.io/

FYI, common Ruby metaprogramming hooks include:
inherited, triggered when a sub-class is created
included, triggered when the module is included
extended, triggered when the module is extended
Kernal#at_ext

ror learning path
http://www.readysetrails.com/index.php/181/this-is-why-learning-rails-is-hard/

http://rubylearning.com/blog/