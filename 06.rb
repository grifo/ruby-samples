#!/usr/bin/ruby -w

words = %w(Jane, aara, multiko)
puts words.map(&:upcase)

puts '-------------'

class Chameleon
  alias __inspect__ inspect

  # METHOD MISSING
  def method_missing(method, *arg)
    if method.to_s[0, 3] == "to_"
      @identity = __inspect__.sub("Chameleon", method.to_s.sub('to_','').capitalize)
      def to_s
        @identity
      end
      self
    else
      super
    end
  end

  # OUTRA
  def outra
    def como
      puts '"como" existe'
    end
    self
  end

end

a = Chameleon.new
puts a.to_rock
a.outra.como

puts '-------------'

class MyClass
  @one = 1
  def do_something
    @one = 2
  end
  def output
    puts @one
  end
end
instance = MyClass.new
instance.output
instance.do_something
instance.output

puts '-------------'

class Employee
  #  class << self
  #    attr_accessor :instances
  #  end
  def self.instances
    @instances
  end
  def self.instances= value
    @instances = value
  end

  def store
    self.class.instances ||= []
    self.class.instances << self
  end
  def initialize name
    @name = name
  end
end
class Overhead < Employee; end
class Programmer < Employee; end
Overhead.new('Martin').store
Overhead.new('Roy').store
Programmer.new('Erik').store
puts Overhead.instances.size    # => 2
puts Programmer.instances.size  # => 1

puts '-------------'

class SingletonLike
  private_class_method :new
  attr_accessor :num

  def SingletonLike.create(*args, &block)
    @@inst ||= new(*args, &block)
  end
end

SingletonLike.create.num = 2
puts SingletonLike.create.num

puts '-------------'

class AccessPrivate
  def a
    puts 'def a'
  end
  private :a # a is private method

  def accessing_private
    a              # sure!
    #self.a         # nope! private methods cannot be called with an explicit receiver at all, even if that receiver is "self"

    #other_object = self.class.new
    #other_object.a # nope, a is private, you can't get it (but if it was protected, you could!)
  end
end

AccessPrivate.new.accessing_private

puts '-------------'

class X
  def foo
    "hello"
  end
end

class Y < X
  alias xFoo foo
  def foo
    xFoo + "y"
  end
end

puts X.new.foo
puts Y.new.foo

puts '-------------'

module A
  def a1; puts 'a1 is called'; self; end
  def a2; puts 'a2 is called'; self; end
end

module B
  def b1; puts 'b1 is called'; self; end
end

class Test
  include A, B
end

Test.new.a1.b1.a2

puts '-------------'

puts "%d %s" % [3.8, "rubies"]

a = '1'
b = '2'
puts "     a:%s b:%s" % [a, b]
a, b = b, a
puts "SWAP a:%s b:%s" % [a, b]

puts '-------------'

def polar(x,y)
  theta = Math.atan2 y, x
  r = Math.hypot x, y
  [r, theta]
end

distance, angle = polar 2, 2
puts distance, angle

puts '-------------'

puts 'match 5 digits'
puts  '21312312'.match(/\d{5}/)

puts '-------------'

class Sequence
  include Enumerable

  def initialize(from, to, by)
    @from, @to, @by = from, to, by
  end

  def each
    x = @from
    while x <= @to
      yield x
      x += @by
    end
  end

  def length
    return 0 if @from > @to
    Integer((@to-@from)/@by) + 1
  end

  alias size length

  def [](index)
    return nil if index < 0
    v = @from + index*@by
    if v <= @to
      v
    else
      nil
    end
  end

  def *(factor)
    Sequence.new(@from*factor, @to*factor, @by*factor)
  end

  def +(offset)
    Sequence.new(@from+offset, @to+offset, @by)
  end

  def to_s
    str = '[S: '
    each {|x| str += "#{x}, " }
    str + ']'
  end
end

s = Sequence.new(1, 10, 2)
puts s
puts s[s.size-1]
puts ((s+1)*2)

puts '-------------'


class Range
  def by(step)
    x = self.begin
    e = self.end
    if exclude_end?
      e -= 1
    end

    while x <= e
      yield x
      x += step
    end
  end
end

(0..10).by(5) {|x| print x}
puts ''
(0...10).by(5) {|x| print x}



