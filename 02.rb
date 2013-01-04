#!/usr/bin/ruby -w


def test
  puts 'oi'
  #  class Fixnum
  #    def +
  #      'oi'
  #    end
  #  end
end

['uno', 'due', :asds].each{|num| puts num}
test
puts 1.class
puts 2+2
#v = {|num| puts num}

name = "oi"
puts "\aYour name is #{name}\t\t\t\to\a", "2", 9, 9.class
print :oi, 'iu', '9', 'asds'

puts <<text
sdf
sdf
sdfdsfsd
sdf
dsfds
sdf
text
puts %Q(asdsada\nsd)

puts "asdas"[0]
('a'..'z').each do |num|
  puts num
end

puts "jean".upcase!

puts rand

if true then puts :oi
  puts 'sad'
end

puts :oi if false

case '2'
when '0'..'9'
  puts '0..10'
when 11
  puts 'oi'
end

4.times {|x| puts "loop #{x}"}

def interact (time, value)
  time.times do |i|
    yield value, i
  end
end

interact 20, 'oi' do |v1, v2|
  puts "#{v1} - #{v2}"
end

puts :oi_aqui.object_id

Rubens = 'rubens'
#Rubens = 'outro'
puts Rubens

puts :aqui_tem_symbol

hash = {:a => 'a1', :b => 'b2', :c => 'c3'}
hash.each {|key, value| puts value}

r = Hash.[] :a1 => 'opa', '2' => '-oi-', :a3 => 'oie/', '2' => '-o2-'
puts r
r.delete '2'
puts r


Hash.[](:leia => "Princess from Alderaan", :la => "Rebel without a cause", :luke => "Farmboy turned Jedi").each do |key, value|
  puts value
end
Hash[:leia => "Princess from Alderaan", :la => "Rebel without a cause", :luke => "Farmboy turned Jedi"].each do |key, value|
  puts value
end

puts '-----'
#puts [0..10].to_a
r = [:teste, 'oi', 6, 7, 8]
#puts r[2..3]
r.push 'oi2', 'oi'
range = 0..10
(r.concat Range.new(2, 6).to_a).push 'funciona'
r.push 'asdsd'.upcase
r.<< 2


#puts (0..10).to_a

puts r.join" "

t = "\t"
puts t*2+'here'

'testes'.scan(/../) {|l| puts l}
puts 'y' if 'number9' =~ /[0-9]/
puts '2+2=4'.sub('2','5')
puts '2+2=4'.gsub('2','5')

1.upto 2 do |number|
  puts "#{number} Ruby loops, ah-ah-ah!"
end

4.downto(1) {|x| puts x}

5.step 50, 5 do |x|
  puts x
end

puts 98.6.to_s
puts 4.9.to_i
puts 5.to_f

puts '1'.next, '9'.next

nxt = 'Next'
20.times do
  puts nxt = nxt.next
end

def anything
  'nada disso rola'
  'oie'
end
def otherthing
  'oie2'
end
puts anything

puts '----------'
def thing (*obj)
  obj.each do |num|
    print "#{num}."
    if num.class == Fixnum
      print ' NUMpq '
    end
    if num.is_a? Integer
      print ' NUM '
    end
    print "\n"
  end
end
thing 10000000000000000, 2

puts '----------'

#def ==(oVal)
#  print 'oi'
#   if oVal.is_a?(Integer)
#       print 'oi'
#       if(oVal == @value)
#           return true
#       else
#           return false
#       end
#   end
#end

class Chocolate
  def initialize
    puts 'oi'
  end
  def eat
    puts 'That tasted great!'
  end
end
my_chocolate = Chocolate.new

Choco = Chocolate
puts Choco.new.eat.class

## SEND: 'conceito de smalltalk'
puts '1234'.send 'length'

class Integer
  def more (num=1)
    self + num
  end

  def self.metodo
    puts '--metodo--'
  end

  class << self
    def shape
      "strawberry-ish"
    end
  end
end

puts 21.more
v = 21.more 20
puts v

Integer.metodo
puts Integer.shape

puts 'eh bacana
escrever assim'


i0 = 1
loop{
  i1 = 2
  puts defined? i0
  puts defined? i1
  break
}
if true
  i2 = 3
end
puts defined? i0
puts defined? i1
puts defined? i2


class Counter
  @@counter=0
  def initialize
    @@counter += 1
  end

  def self.what
    @@counter
  end
end

eval "Counter.new;"*5
puts Counter::what

puts '----------'

class B
  def go
    A2
  end
end

class A
  A2 = 'a2'
  class B
    def go
      A2
    end
  end
end
ab = A::B.new
puts ab.go
puts A::A2

puts '----------'
puts 'REGEX'

puts 'obaoba'.match(/(a)(o)/)
puts $`+ '"' + $& + '"' + $'
puts $+ # ultimo ()
puts $1 + '&' + $2
puts $~

puts '----------'

$\ = "-cuzon\n" # posso fazer print = puts
print 'eh um'

$, = ' VIR '
print 'agora', 'eh', 'mais', 'legal'

puts "asd"

$; = 'i' # default eh nil
puts 'print$;'.split






