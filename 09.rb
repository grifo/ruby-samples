class Point
  def initialize(x,y)
    @x,@y = x,y
  end

  private_class_method :new
  def Point.cartesian(x,y)
    new(x,y)
  end
  def Point.polar(r, theta)
    new(r*Math.cos(theta), r*Math.sin(theta))
  end
end

class Point2 < Point; end

p Point2.polar(2, 1)
n = Point2.new(2,1) rescue 'ops'
p n
p 'po'

puts '-------------'

class PointDup
  UMACONSTANTE = ''
  @@sopraver = ''
  def initialize(*coords)
    @coords = coords
  end
  def initialize_copy(orig)
    @coords = @coords.dup
  end
end

puts '-------------'

class Season
  NAMES = %w{ Spring Summer Autumn Winter }
  INSTANCES = []

  def initialize(n)
    @n = n
  end
  def to_s
    NAMES[@n]
  end

  NAMES.each_with_index do |name,index|
    instance = new(index)
    INSTANCES[index] = instance
    const_set name, instance
    # Define a constant to refer to it
  end

  def _dump(limit)
    @n.to_s
  end
  def self._load(s)
    INSTANCES[Integer(s)]
  end

  private_class_method :new,:allocate
  private :dup, :clone
end


puts '-------------'
require 'singleton'

class PointStat
  include Singleton
  def initialize
    @n, @totalX, @totalY = 0, 0.0, 0.0
  end
  def record(point)
    @n += 1
    @totalX += point.x
    @totalY += point.y
  end
  def report
    puts "Number of points created: #@n"
    puts "Average X coordinate: #{@totalX/@n}"
    puts "Average Y coordinate: #{@totalY/@n}"
  end

  class << self
    # class methods go here as instance methods of the eigenclass
  end
end

#def initialize(x,y)
#  @x,@y = x,y
#  PointStats.instance.record(self)
#end

puts '-------------'

# If your class defines <=>, you can mix
# in Comparable to get <, <=, == >, >=,
# and between? for free.

puts '-------------'

countdown = Object.new
def countdown.each
  yield 3
  yield 2
  yield 1
end
countdown.extend(Enumerable)
print countdown.sort, "\n"

puts '-------------'

puts Math.sin(0)
include Math
puts sin(0)

puts '-------------'

puts $LOAD_PATH

puts '-------------'

class << PointStat
  def class_method1
    puts 'oi'
  end
  def class_method2
  end
end

PointStat.class_method1

puts '-------------'

def Integer.parse(text)
  text.to_i
end
p Fixnum.parse("1")
p PointStat.inspect

p String.ancestors
p Fixnum.ancestors

class Object
  def const_missing name
    'fuck'
  end
end
class <<  Object
  def const_missing name
    'fuck instance'
  end
end

class Opa
  def oi
    p S
  end
  p S
end

Opa.new.oi

puts '-------------'

p String.ancestors
p String.included_modules

module StringTest
  def test
    p 'test'
  end
end

String.extend StringTest
String.test

puts '-------------'

module M2
  class C2
    p Module.nesting
  end
end

puts '-------------'

M = Module.new
C = Class.new
D = Class.new(C) {
  include M
}
p D.to_s

puts '-------------'

x = 1
p eval "x + 1"

puts '-------------'

class Object
  def bindings
    binding
  end
end
class Test
  def initialize(x); @x = x; end
end
t = Test.new(10)
p (eval '@x', t.bindings)
p t.instance_eval("@x")

String.class_eval {
  alias len size
}
p "123".len

String.instance_eval{
  def empty
    ''
  end
}
p String.empty

puts '-------------'
p global_variables
puts '-------------'
p local_variables
puts '-------------'

p PointDup.new.instance_variables
p PointDup.class_variables
p PointDup.constants

puts '-------------'

o = Object.new
o.instance_variable_set :@x, 0
o.instance_variable_get :@x
p o.instance_variable_defined? :@x

p Season.constants
p Season::Summer

puts '-------------'

Math.const_set :EPI, Math::E*Math::PI
p Math.const_get :EPI
p Math.const_defined? :EPI

# o.instance_eval { remove_instance_variable :@x }
# String.class_eval { remove_class_variable(:@@x) }
Math.send :remove_const, :EPI
p Math.const_defined? :EPI

puts '-------------'

def Symbol.const_missing(name)
  name
end
p Symbol::FuckRehab

puts '-------------'
p "".methods
puts '-------------'
p "".public_methods false #Exclude inherited methods
puts '-------------'
p PointStat.singleton_methods
puts '-------------'
p String.singleton_methods
puts '-------------'

p String.instance_methods == "s".public_methods
p String.instance_methods(false) == "s".public_methods(false)
p String.public_instance_methods == String.instance_methods

p String.private_instance_methods false

puts '-------------'
p Math.singleton_methods
puts '-------------'

p String.public_method_defined? :reverse
p String.protected_method_defined? :reverse
p String.private_method_defined? :initialize
p String.method_defined? :upcase!

puts '-------------'

p "s".method :reverse # => Method object
p String.instance_method :reverse # => UnboundMethod object

"hello".send :puts, "world"

puts '-------------'

def add_method(c, m, &b)
  c.class_eval {
    define_method m, &b
  }
end

add_method(String, :greet) { "Hello, " + self }

p "world".greet


def add_class_method(c, m, &b)
  eigenclass = class << c; self; end
  eigenclass.class_eval {
    define_method(m, &b)
  }
end
add_class_method(String, :greet) {|name| "Hello, " + name }
p String.greet "world"

puts '-------------'

def backup(c, m, prefix="original")
  n = :"#{prefix}_#{m}"
  c.class_eval {
    alias_method n, m
  }
end
backup String, :reverse
p "test".original_reverse

puts '-------------'

class Hash
  def method_missing(key, *args)
    text = key.to_s
    if text[-1,1] == "="
      self[text.chop.to_sym] = args[0]
    else
      self[key]
    end
  end
end

h = {}
h.one = 1
puts h.one

puts '-------------'

def Object.inherited c
  puts "class #{c} < #{self}"
end

module Final
  def self.included(c)
    c.instance_eval do
      def inherited(sub)
        raise Exception, "Attempt to create subclass #{sub} of Final class #{self}"
      end
    end
  end
end

class ToVendo; include Final; end
# class NaoPode < ToVendo; end

puts '-------------'

def String.method_added(name)
  puts "New instance method #{name} added to String"
end

def String.singleton_method_added(name)
  puts "New class method #{name} added to String"
end

module Strict
  def singleton_method_added(name)
    STDERR.puts "Warning: singleton #{name} added to a Strict object"
    eigenclass = class << self; self; end
    eigenclass.class_eval { remove_method name }
  end
end

class String
  def oi; end;
  include Strict
end

class String
  def oi2; end;
end

class << ""
  def error; end
end
puts '-------------'
ObjectSpace.each_object(Class) {|c| puts c }
puts '-------------'


