words = ['and', 'but', 'car']
uppercase = words.map &:upcase
puts uppercase

puts '-------------'

p lambda{|x,y| x+y}.arity

puts '-------------'

# Return a lambda that retains or "closes over" the argument n
def multiplier(n)
  b = lambda {|data| data.collect{|x| x*n } }
  n *= 20
  b
end
doubler = multiplier(2)
puts doubler.call([1,2,3]) # Prints 2,4,6

eval("n=3", doubler) # Or doubler.binding.eval("n=3") in Ruby 1.9
puts doubler.call([1,2,3])

puts '-------------'

def accessor_pair(value)
  getter = lambda { value }
  setter = lambda {|x| value = x }
  [getter, setter]
end

getX, setX = accessor_pair(0)
puts getX[]
setX[10]
puts getX[]

puts '-------------'

m = 0.method :succ
p m.call

puts '-------------'

def square(x); x*x; end
puts (1..10).map &method(:square)

puts '-------------'

class Point
  include Comparable
  include Enumerable
  attr_accessor :x, :y  # Define accessor methods for our instance variables

  def initialize(x,y)
    @x,@y = x, y
  end

  def +(other)
    # Define + to do vector addition
    Point.new(@x + other.x, @y + other.y)
  end

  def add(p)
    q = self.dup
    q.add!(p)
  end
  def add!(p)
    @x += p.x
    @y += p.y
    self
  end

  def -@
    # Define unary minus to negate both coordinates
    Point.new(-@x, -@y)
  end

  def *(scalar)
    # Define * to perform scalar multiplication
    Point.new(@x*scalar, @y*scalar)
  end

  def to_s
    "(#@x,#@y)"
  end

  # If we try passing a Point to the * method of an Integer, it will call
  # this method on the Point and then will try to multiply the elements of
  # the array. Instead of doing type conversion, we switch the order of
  # the operands, so that we invoke the * method defined above.
  def coerce(other)
    [self, other]
  end

  def [](index)
    case index
    when 0, -2: @x
    when 1, -1: @y
    when :x, 'x': @x
    when :y, 'y': @y
    else nil
    end
  end

  def each
    yield @x
    yield @y
  end

  def ==(o)
    def ==(o)
      @x == o.x && @y == o.y
    rescue
      false
    end
    #    if o.is_a? Point
    #      @x==o.x && @y==o.y
    #    elsif
    #      false
    #    end
  end
  # is used to hash key compare
  alias eql? ==

  def hash
    code = 17
    code = 37*code + @x.hash
    code = 37*code + @y.hash
    code
  end

  def <=>(other)
    return nil unless other.instance_of? Point
    @x**2 + @y**2 <=> other.x**2 + other.y**2
  end
end


puts 2*Point.new(1, 2)
puts Point.new(0, 0).all? {|x| x == 0 } # p at the origin

puts '-------------'

Point2 = Struct.new(:x, :y)

p = Point2.new(1,2)
p p.x
p p.y
p p.x = 3
p p.x

p[:x] = 4
p p[:x]
p p[1]
p.each {|c| print c} # prints "42"
puts ''
p.each_pair {|n,c| puts "#{n}:#{c}" }

puts "\n"+'-------------'

class Point2
  undef x=,y=,[]=
  ORIGIN = self.new(0,0)
  UNIT_X = self.new(1,0)
  UNIT_Y = self.new(0,1)

  @teste_tosco = 'tosco'

  @@n = 0
  @@totalX = 0
  @@totalY = 0

  def initialize(x,y)
    super x, y
    @@n += 1
    @@totalX += x
    @@totalY += y

    p @teste_tosco
  end

  def add!(other)
    self.x += other.x
    self.y += other.y
    self
  end

  include Comparable
  def <=>(other)
    return nil unless other.instance_of? Point
    self.x**2 + self.y**2 <=> other.x**2 + other.y**2
  end

  def self.sum(*points)
    x = y = 0
    points.each {|p| x += p.x; y += p.y }
    Point2.new(x,y)
  end

  class << self
    # Class methods go here
    def report
      puts "Number of points created: #@@n"
      puts "Average X coordinate: #{@@totalX.to_f/@@n}"
      puts "Average Y coordinate: #{@@totalY.to_f/@@n}"
      p @teste_tosco
    end
  end
end

begin
  p p.x = 3
rescue
  puts 'ops'
end

Point2::NEGATIVE_UNIT_X = Point2.new(-1,0)

p Point2::NEGATIVE_UNIT_X
p Point2::UNIT_X

Point2.report

puts '-------------'

class Point3
  @n = 9000
  puts '** quero ver'
  def initialize(x,y)
    @x, @y = x, y
  end
  def self.new(x,y)
    @n = @n + 1 rescue 1
    @totalX = @totalX + x rescue x
    @totalY = @totalY + y rescue y
    super
  end

  def self.report
    puts "Number of points created: #@n"
    puts "Average X coordinate: #{@totalX.to_f/@n}"
    puts "Average Y coordinate: #{@totalY.to_f/@n}"
  end

  class << self
    attr_accessor :n, :totalX, :totalY
  end
end

class Point4 < Point3; puts '** e agora' end

p = Point3.new(20, 15)
Point3.report
puts '-------------'
Point4.new(21, 16)
Point3.report
puts '-------------'
Point4.report

puts '-------------'


class Point3D < Struct.new(:x, :y, :z)
  # Superclass struct gives us accessor methods, ==, to_s, etc.
  # Add point-specific methods here
end

puts '-------------'

class A
  @@value = 1
  def A.value; @@value; end
end
print A.value
class B < A; @@value = 2; end
print A.value
class C < A; @@value = 3; end
print B.value

puts '', '-------------'

module Unicode
  def self.const_missing(name)
    if name.to_s =~ /^U([0-9a-fA-F]{4,5}|10[0-9a-fA-F]{4})$/
      codepoint = $1.to_i 16
      utf8 = [codepoint].pack "U"
      utf8.freeze
      const_set name, utf8
    else
      raise NameError, "Uninitialized constant: Unicode::#{name}"
    end
  end
end

puts copyright = Unicode::U00A9
puts euro = Unicode::U20AC
puts infinity = Unicode::U221E








