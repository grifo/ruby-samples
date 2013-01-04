#!/usr/bin/ruby -w

def f(n)
  puts n
  return n
end

def s
  puts 'ã'
end

#exit!

def at_exit
  puts 'bye'
end

s
f(3+2) +1

puts Float::MAX

puts even = (20[0] == 0)

puts '-------------'

puts (0.4 - 0.3 == 0.1)

puts `ls`

puts '-------------'

4.times { puts :test.object_id }

puts '-------------'


greeting = "Hello"
greeting << " " << "World"
puts greeting

puts '-------------'

puts VERSION
puts `ruby -v`

puts '-------------'

s = 'hello'
s[0] = ?H
s[-1] = ?O
s[-1] = ""
s[1] = '&'
s[1..2] = 'oi'
puts s

puts '-------------'

s = "hellõ"
while(s["l"])
  s["l"] = "L";
end
s['eL'] = '&'
s['õ'] = 'ã'
puts s

puts '-------------'

s = 'trocã primeira võgal por asterisco'
puts s.length
s[/[aeiouã]/] = '*'
s[/[ã]/] = 'a'
puts s

puts '-------------'

puts 'ãa'[2]

puts '-------------'
puts Array.new 4, 'xs'
puts '-------------'

a = []
a[2] = 2
puts a

puts '-------------'

puts s[1..-1]

puts '-------------'

a = []
a << 1
a << 2 << 3
a << [4,5,6]
p a

puts '-------------'

p a*3

puts '-------------'
a = [1, 1, 1, 1, 2, 2, 3]
p a | a # uniao de 'conjuntos'
p a & a # interseccao de 'conjuntos'
puts '-------------'

class RangeCrazy
  attr_accessor :value

  def initialize(value)
    @value = value
  end

  def coerce(instance)
    @value.coerce instance
  end

  def <=>(instance)
    @value<=> instance
  end

  def succ
    @value.succ
  end
end

r = RangeCrazy.new(2)..RangeCrazy.new(4);
puts r.to_a

puts '-------------'

p :'simbolo com espaço'

p [].respond_to? :each

puts '-------------'
puts 'a' == "a"
puts String === 'b'

puts 'b'.hash

puts '-------------'
p 'any thing is a Object'.is_a? Object
p 'but not a instance of Object'.instance_of? Object
puts '-------------'

puts '=== é usado em CASE'
p (1..10) === 5
p (1..10) == 5
p /\d+/ === "123"
p String === "s"
p 's' === "s"


puts '-------------'

p 1.between?(0,10)
# true: 0 <= 1 <= 10

s = "ice"
s.freeze
s.frozen?
#s.upcase!
#s[0] = "ni"

class String
  UMACONSTANTE = 'oi'
end

puts String::UMACONSTANTE
puts a2 = 'oi' unless a2

puts '-------------'
x, y, z = 1, *[2,3]
p x, y, z
puts '-------------'


class String
  def -@
    '-'
  end
end
puts -"oi"

puts '-------------'
x = 'print'
x && puts(x.to_s)
puts x if x

puts '-------------'

(1..10).each {|x| print x if x==3..x==5 }

puts "\n"+'-------------'

puts case 2.0
when String then "string"
when Numeric then "number"
when TrueClass || FalseClass then "boolean"
else "other"
end

puts '-------------'

puts 'continue = NEXT'

def hasValue?(x)
case x
when [], "", 0, nil, false
  false
else
  true
end
end

puts hasValue? []
puts hasValue? 0
puts hasValue? ""
puts hasValue? nil
puts hasValue? false
puts hasValue? 'oi'

puts '-------------'
x = 0
puts x = x + 1 while x < 10

puts '-------------'

# Print the elements in an array
array = [1,2,3,4,5]
for element in array
puts element
end
# Print the keys and values in a hash
hash = {:a=>1, :b=>2, :c=>3}
for key,value in hash
puts "#{key} => #{value}"
end

puts '-------------'

0.step(Math::PI, 0.1) {|x| puts Math.sin(x) }

evens = (1..10).select {|x| x%2 == 0} # => [2,4,6,8,10]
odds = (1..10).reject {|x| x%2 == 0} # => [1,3,5,7,9]

puts '-------------'


def sequence(n, m, c)
i, s = 0, []
while i < n
  y = m*i + c
  yield y if block_given?
  s << y
  i += 1
end
s
end

puts (sequence 4, 2, 0.1)

puts '-------------'

s = "helloã"
s.enum_for(:each_char).map {|c| puts c.succ }
p s.each_byte.to_a

puts '-------------'

s = (1..10).select do |x|
next if x==6
x%2 == 0
end
puts s

puts '-------------'
1.upto(10) do |i|
1.upto(10) do |i|
  print "#{i} "
end
print " ==> Row #{i}\n"
end

puts '-------------'

# return from find
def find(array, target)
array.each_with_index do |element,index|
  return index if (element == target)
end
nil
end

# break
def find2(array, target)
value = array.each_with_index do |element,index|
  break index if (element == target)
end
value unless value == array
#value unless value.is_a? Array
end

puts find [1,1,3,3,3,4,5], 3
puts find2 [1,1,3,3,3,4,5], 3
puts find2 [1,1,3,3,3,4,5], 6

puts '-------------'
puts caller 0
puts '-------------'
puts 'EXCEPTION:'


def factorial(n)
raise TypeError, "Integer argument expected" if not n.is_a? Integer
raise ArgumentError, 'bad argument' if n < 1
return 1 if n == 1
n * factorial(n-1)
end

#raise 'bad argument' if n < 1
#raise RuntimeError, "bad argument" if n < 1
#raise RuntimeError.new("bad argument") if n < 1
#raise RuntimeError.exception("bad argument") if n < 1

begin
puts factorial 0
puts factorial '0'
rescue => ex
puts "#{ex.class}: #{ex.message}"
p $!
rescue ArgumentError => ex
puts "Try again with a value >= 1"
rescue TypeError => ex
puts "Try again with an integer"
end

puts '-------------'

def explode
raise "bam!" if rand(10) == 0
end
def risky
begin
  10.times do
    explode
  end
rescue TypeError
  puts $!
end
"hello"
end

def defuse
begin
  puts risky
rescue RuntimeError => e
  puts e.message
end
end

defuse

puts '-------------'

def get
require 'open-uri'
tries = 0

begin
  tries += 1
  open('http://www.curecriativa.com/') {|f| puts f.readlines }
rescue OpenURI::HTTPError => e
  puts e.message
  if tries < 4
    sleep(2**tries)
    retry
  end
end
end

puts '-------------'

def method_name(x)
# The body of the method goes here.
# Usually, the method body runs to completion without exceptions
# and returns to its caller normally.
rescue
# Exception-handling code goes here.
# If an exception is raised within the body of the method, or if
# one of the methods it calls raises an exception, then control
# jumps to this block.
else
# If no exceptions occur in the body of the method
# then the code in this clause is executed.
ensure
# The code in this clause is executed no matter what happens in the
# body of the method. It is run if the method runs to completion, if
# it throws an exception, or if it executes a return statement.
end

puts '-------------'

# Global hash for mapping line numbers (or symbols) to continuations
$lines = {}
# Create a continuation and map it to the specified line number
def line(symbol)
callcc {|c| $lines[symbol] = c }
end
# Look up the continuation associated with the number, and jump there
def goto(symbol)
$lines[symbol].call
end

# Now we can pretend we're programming in BASIC
i = 0
line 10
puts i += 1
goto 10 if i < 5
line 20
puts i -= 1
goto 20 if i > 0


puts '-------------'
o = "message"
def o.printme
puts self
end
o.printme

puts '-------------'
def sum(x,y); x+y; end
puts sum(1,2)
undef sum

# alias new_name existing_name

puts '-------------'

def suffix(s, index=s.size-1)
s[index, s.size-index]
end

p suffix 'fuck'

puts '-------------'
def max(max, *rest)
rest.each {|x| max = x if x > max }
max
end
p max(1,2,4,5,1,2,3,4)
data = [2,3,4,1,23,2,24]
p max *data

puts '-------------'

p max(*'hello world'.each_char)

puts '-------------'

def sequence3(n, m, c, &b)
i = 0
while(i < n)
  b.call(i*m + c)
  i += 1
end
end
sequence3 5, 2, 2, &lambda {|x| puts x }

