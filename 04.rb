#!/usr/bin/ruby -w

puts 'o'
print 'numero: '
puts $.

puts $<
puts $>
puts $_

puts '-------------'
puts $$
puts $:

puts '-------------'

puts $"
puts $LOADED_FEATURES
puts $DEBUG
puts $FILENAME
puts $KCODE, $LOAD_PATH


puts '-------------'

puts __LINE__
puts (-123.class)
puts 0xFFFFFF.class
puts 010
puts 0b11
puts ?a
puts 102.chr
puts "a6" << 102
puts "the error is #{1.0/2}"
puts %(fghfgh 78% asdas)
puts 'opaX'.match %r[a.]
puts %s(oi d)
puts %s[oi hg u]

puts '-------------'

puts %w[essa \""e''h massa #{1+2}]
puts :OK
puts %W[essa \""eh massa #{1+1}]

puts '-------------'

print [<<END, "short", "strings\n\n"]
  1
    2
  3
END

print [<<ONE, <<TWO, <<THREE]
  the first thing
ONE
  the second thing
TWO
  and the third thing #{3+9}
THREE
puts '-------------'

puts %W'a b c #{2+1}'
## START, COUNT
puts ['a', 'b', 'c', 'd', 'e', 'f'][-4,10][1..3]

puts '-------------'

puts 'olha o split'.split.join '-,-'
puts (Array.new 4).fill('preenche tudo igual')

h = {:a => 1, :b => 2, :c => 3}
puts h

if (0..4) === 3
  puts 'yep'
end

a = ['a', 'b', 'c']
puts *a

myArray = %w(John Michel Fran Adolf)
var1, var2, var3, var4 =* myArray
puts var1

puts '-------------'

puts false || 'o'

f = false
f ||= 'agora sim'
f ||= 'agora nao'
puts f

puts '-------------'

y = 'vai mostrar isso'
y = "(some fallback value)" unless y
puts y

if not nil
  puts 'eras'
end

class Rt
  def mt
    return b = 'o' if false
    return 'vale esse'
  end
end

rt = Rt.new
puts rt.mt

puts '-------------'

if false
  bunda = 'coisa'
end
p bunda

bunda &&= 'ã'
puts bunda

bunda ||= 'ã'
puts bunda

bunda &&= 'o'
puts bunda

puts '-------------'

4.times do |$global| 
  $global = $global*2 
end
puts $global

puts '-------------'

class Pot2
  def initialize
    @value = 1
  end
  def go
    @value *= 2
    self
  end
  def to_s
    @value.to_s
  end
end

class Pot2s < Pot2
  @@value = 1
  def go
    @@value *= 2
    self
  end
  def to_s
    @value = @@value
    super
  end
end

class Pot2S < Pot2
  @@value = 1
  def initialize
    @value = @@value
  end
  def go
    super
    @@value = @value
    self
  end
end

puts (1..10).inject(Pot2.new) { |obj, i| obj.send(:go) }

puts (1..10).inject(Pot2s.new) { |obj, i| obj.go }
puts (1..10).inject(Pot2s.new) { |obj, i| obj.go }

puts (1..10).inject(Pot2S.new) { |obj, i| obj.go }
puts (1..10).inject(Pot2S.new) { |obj, i| obj.go }


@a = 2
puts @a

puts '-------------'

$go = :go
class Teste
  if $go == :go
    def self.foo
      3
    end
  else
    def self.foo
      4
    end
  end
end

puts Teste.foo

puts '-------------'

a = 25
b = proc do 
  a 
end
puts b.call

puts '-------------'

class TesteEscopo
  a = 3
  b = :go
  define_method b do
    a
  end
  define_method :succ do
    a += 1
    self
  end
end

puts TesteEscopo.new.succ.succ.go

puts '-------------'

a = 3
PROC = proc { a }
class A
  define_method :go, PROC
end
puts A.new.go
a = 4
puts A.new.go

if 0
  puts 'zero é verdadeiro'
end

puts '* conditionals are expression'
a = if 0 then 2 else 3 end
puts a


puts true ? 't' : 'f'



a = 1
case 
  when a < 5 then puts "#{a} less than 5"    
  when a == 5 then puts "#{a} equals 5"   
  when a > 5 then puts "#{a} greater than 5" 
end

while a < 5
  a += 1
  puts a
end


puts (1..10).each { |i| 
  break i if i > 5 
}


puts '-------------'

def calculate_value(x, y, *rest)
  puts rest
end
 
calculate_value(1, 2,'a','b','c')
calculate_value(*[1, 2,'a2','b2','c2'])

puts '-------------'

def foo_hash(var)
  puts var.inspect
end

foo_hash :arg1 => 1, :arg2 => 2, :arg3 => 3

puts '-------------'

def method_call
  yield
end
puts method_call(&PROC)

puts '-------------'

def gen_times(factor)
  Proc.new {|n| n*factor}
end

puts gen_times(3).call(12)

puts '-------------'

def foo(a, b)
  a.call b
end
foo(Proc.new{|x| puts x}, 34)
foo(lambda{|x| puts x+1}, 34)

puts '-------------'

def lamba_proc
  (lambda{ return "Baaam1" }).call
  'oi'
  Proc.new{ |n| return n }["Baaam2"]
  'oi'
  'not printed'
end
puts lamba_proc

puts '-------------'
def contrived(a, &f)
  f[a]
  yield a 
end
contrived(25) {|x| puts x}

def contrived2(a)
  yield a
end
contrived(25, &lambda{|x| puts x})

puts '-------------'
calc = lambda{|n| n*2 }
puts "number: "+((1..10).collect(&calc).join(", "))
puts '-------------'



















