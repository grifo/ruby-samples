module Functional
  #  a = [[1,2],[3,4]]
  #  sum = lambda {|x,y| x+y}
  #  sums = sum|a
  #  => [3,7]
  def apply(enum)
    enum.map &self
  end
  alias | apply

  #  data = [1,2,3,4]
  #  sum = lambda {|x,y| x+y}
  #  total = sum<=data
  #  => 10
  def reduce(enum)
    enum.inject &self
  end
  alias <= reduce

  #  f = lambda {|x| x*x }
  #  g = lambda {|x| x+1 }
  #  (f*g)[2]
  #  => 9
  #  (g*f)[2]
  #  => 5
  def compose(f)
    if self.respond_to?(:arity) && self.arity == 1
      lambda {|*args| self[f[*args]] }
    else
      lambda {|*args| self[*f[*args]] }
    end
  end
  alias * compose

  #  product = lambda {|x,y| x*y}
  #  doubler = product >> 2
  def apply_head(*first)
    lambda {|*rest| self[*first.concat(rest)]}
  end

  #  difference = lambda {|x,y| x-y }
  #  decrement = difference << 1
  def apply_tail(*last)
    lambda {|*rest| self[*rest.concat(last)]}
  end

  alias >> apply_head # g = f >> 2 -- set first arg to 2
  alias << apply_tail # g = f << 2 -- set last arg to 2

  # cached_f = +f
  def memoize
    cache = {}
    lambda {|*args|
      unless cache.has_key? args
        print '*'
        cache[args] = self[*args]
      end
      cache[args]
    }
  end
  alias +@ memoize
end

# Add these functional programming methods to Proc and Method classes.
class Proc; include Functional; end
class Method; include Functional; end


data = [1,2,3,4]
sum = lambda {|x,y| x+y}
puts sum<=data

a = [1,2,3,4,5]
puts (sum<=a)/a.size

factorial = +lambda do |x|
  return 1 if x==0
  x*factorial[x-1]
end

p factorial[20]
p factorial[10]
p factorial[21]


puts '-------------'


class Module
  alias [] instance_method

  # Define a instance method with name sym and body f.
  # Example: String[:backwards] = lambda { reverse }
  def []=(sym, f)
    self.instance_eval { define_method(sym, f) }
  end
end
#
p String[:reverse].bind("hello").call

class UnboundMethod
  alias [] bind
end
#
p String[:reverse]["hello"][]



Enumerable[:average] = lambda do
  sum, n = 0.0, 0
  self.each {|x| sum += x; n += 1 }
  if n == 0
    nil
  else
    sum/n
  end
end
