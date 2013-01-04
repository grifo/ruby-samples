(5..7).each {|x| print x }                 # Prints "567"
puts ''

(5..7).each_with_index {|x,i| print x,i }  # Prints "506172"
puts ''

(1..10).each_slice(4) {|x| p x } # Prints "[1,2,3,4][5,6,7,8][9,10]"
puts ''

(1..5).each_cons(3) {|x| p x }

puts '-------------------'

p data = [1,2,3,4]                        # An enumerable collection
p roots = data.collect {|x| Math.sqrt(x)} # Collect roots of our data
p words = %w[hello world]                 # Another collection
p upper = words.map {|x| x.upcase }       # Map to uppercase

puts '-------------------'

(1..3).zip([4,5,6]) {|x| p x } # Prints "[1,4][2,5][3,6]"
(1..3).zip([4,5,6],[7,8]) {|x| p x}    # Prints "14725836"
(1..3).zip('a'..'c') {|x,y| print x,y }    # Prints "1a2b3c"

puts '-------------------'

p "Ruby".each_char.max       # => "y"; Enumerable method of Enumerator

puts '-------------------'

iter = "Ruby".each_char    # Create an Enumerator
loop { p iter.next }   # Prints "Ruby"; use it as external iterator

print iter.next            # Prints "R": iterator restarts automatically
iter.rewind                # Force it to restart now
print iter.next            # Prints "R" again

puts '', '-------------------'

w = %w(apple Beet carrot)  # A set of words to sort
p w.sort                         # ['Beet','apple','carrot']: alphabetical
p w.sort {|a,b| b <=> a }          # ['carrot','apple','Beet']: reverse
p w.sort {|a,b| a.casecmp b }   # ['apple','Beet','carrot']: ignore case
p w.sort {|a,b| b.size <=> a.size} # ['carrot','apple','Beet']: reverse length

puts '-------------------'

# Case-insensitive sort
words = ['carrot', 'Beet', 'apple']
p words.sort_by {|x| x.downcase}       # => ['apple', 'Beet', 'carrot']

puts '-------------------'

primes = [2, 3, 5, 7]
p primes.include? 2        # => true
p primes.member? 1         # => false

puts '-------------------'

data = [[1,2], [0,1], [7,8]]
p data.find {|x| x.include? 1}     # => [1,2]
p data.detect {|x| x.include? 3}   # => nil: no such element

puts '-------------------'

p (1..8).select {|x| x%2==0}    # => [2,4,6,8]: select even elements
p (1..8).find_all {|x| x%2==1}  # => [1,3,5,7]: find all odd elements

primes = [2,3,5,7]
p primes.reject {|x| x%2==0}  # => [3,5,7]: reject the even ones

puts '-------------------'

p (1..8).partition {|x| x%2==0}  # => [[2, 4, 6, 8], [1, 3, 5, 7]]

langs = %w[ java perl python ruby ]
langs.grep(/^p/)                    # => [perl, python]: start with 'p'
p langs.grep(/^p/) {|x| x.capitalize} # => [Perl, Python]: fix caps

puts '-------------------'

data = [1, 17, 3.0, 4]
p ints = data.grep(Integer)           # => [1, 17, 4]: only integers
p small = ints.grep(0..9)             # [1,4]: only in range

puts '-------------------'

p [1,2,3,nil,4].take_while {|x| x }  # => [1,2,3]: take until nil
p [false, nil, 1, 2].drop_while {|x| !x }   # => [1,2]: drop leading nils

puts '-------------------'

p [10, 100, 1].min    # => 1
p ['a','c','b'].max   # => 'c'

puts '-------------------'

langs = %w[java perl python ruby]    # Which has the longest name?
p langs.max {|a,b| a.size <=> b.size } # => "python": block compares 2
p langs.max_by {|word| word.length }   # => "python": Ruby 1.9 only

puts '-------------------'

p (1..100).minmax                   # => [1,100] min, max as numbers
p (1..100).minmax_by {|n| n.to_s }  # => [1,99]  min, max as strings

puts '-------------------'

c = -2..2
p c.all? {|x| x>0}    # => false: not all values are > 0
p c.any? {|x| x>0}    # => true: some values are > 0
p c.none? {|x| x>2}   # => true: no values are > 2
p c.one? {|x| x>0}    # => false: more than one value is > 0
p c.one? {|x| x>2}    # => false: no values are > 2
p c.one? {|x| x==2}   # => true: one value == 2
p [1, 2, 3].all?      # => true: no values are nil or false
p [nil, false].any?   # => false: no true values
p [false].none?            # => true: no non-false, non-nil values 

puts '-------------------'

a = [1,1,2,3,5,8]
p a.count(1)                # => 2: two elements equal 1
p a.count {|x| x % 2 == 1}  # => 4: four elements are odd

puts '-------------------'

# How many negative numbers?
p (-2..10).inject(0) {|num, x| x<0 ? num+1 : num }  # => 2
p %w[pea queue are].inject(0) {|total, word| total + word.length }  # => 11

puts '-------------------'

p sum = (1..5).inject {|total,x| total + x}  # => 15
p prod = (1..5).inject {|total,x| total * x} # => 120
p max = [1,3,2].inject {|m,x| m>x ? m : x}   # => 3
p [1].inject {|total,x| p 'mentiu'; total + x}           # => 1: block never called

puts '-------------------'

p sum = (1..5).reduce(:+)                    # => 15
p prod = (1..5).reduce(:*)                   # => 120
p letters = ('a'..'e').reduce("-", :concat)  # => "-abcde"

puts '-------------------'

p count = Array.new(3){|i| 3*i+1}
# Array length
p [1,2,3].length     # => 3
p [].size            # => 0: synonym for length
p [].empty?          # => true
p [nil].empty?       # => false
p [1,2,nil].nitems   # => 2: number of non-nil elements

puts '-------------------'

a = %w[a b c d]    # => ['a', 'b', 'c', 'd']
a[0]               # => 'a': first element
a[-1]              # => 'd': last element
a[a.size-1]        # => 'd': last element
a[-a.size-1]       # => 'a': first element
a[5]               # => nil: no such element
a[-5]              # => nil: no such element
a.at(2)            # => 'c': just like [] for single integer argument
a.fetch(1)         # => 'b': also like [] and at
a.fetch(-1)        # => 'd': works with negative args
# a.fetch(5)         # => IndexError!: does not allow out-of-bounds
# a.fetch(-5)        # => IndexError!: does not allow out-of-bounds
a.fetch(5, 0)      # => 0: return 2nd arg when out-of-bounds
p a.fetch(5){|x|x*x} # => 25: compute value when out-of-bounds
a.first            # => 'a': the first element
a.last             # => 'd': the last element
p a.choice           # Ruby 1.9: return one element at random

puts '-------------------'

# Indexing subarrays
a[0,2]             # => ['a','b']: two elements, starting at 0
a[0..2]            # => ['a','b','c']: elements with index in range
a[0...2]           # => ['a','b']: three dots instead of two
a[1,1]             # => ['b']: single element, as an array
a[-2,2]            # => ['c','d']: last two elements
a[4,2]             # => []: empty array right at the end 
a[5,1]             # => nil: nothing beyond that
a.slice(0..1)      # => ['a','b']: slice is synonym for []
a.first(3)         # => ['a','b','c']: first three elements
a.last(1)          # => ['d']: last element as an array

puts '-------------------'

a.values_at(0,2)         # => ['a','c']
a.values_at(4, 3, 2, 1)  # => [nil, 'd','c','b']
a.values_at(0, 2..3, -1) # => ['a','c','d','d']
a.values_at(0..2,1..3)   # => ['a','b','c','b','c','d']

puts '-------------------'

a = [1,2,3]        # Start over with this array
a[3] = 4           # Add a fourth element to it: a is [1,2,3,4]
a[5] = 6           # We can skip elements: a is [1,2,3,4,nil,6]
a << 7             # => [1,2,3,4,nil,6,7]
p a << 8 << 9        # => [1,2,3,4,nil,6,7,8,9] operator is chainable

a = [1,2,3]        # Start over with short array
p a + a              # => [1,2,3,1,2,3]: + concatenates into new array
a.concat([4,5])    # => [1,2,3,4,5]: alter a in place: note no !
p a

a = ['a', 'b', 'c']
a[1,0] = [1,2]
p a

puts '-------------------'

# Removing (and returning) individual elements by index
a = [1,2,3,4,5,6]
a.delete_at(4)     # => 5: a is now [1,2,3,4,6]
a.delete_at(-1)    # => 6: a is now [1,2,3,4]
a.delete_at(4)     # => nil: a is unchanged

# Removing elements by value
a.delete(4)        # => 4: a is [1,2,3]
a[1] = 1           # a is now [1,1,3]
a.delete(1)        # => 1: a is now [3]: both 1s removed
a = [1,2,3]
a.delete_if {|x| x%2==1} # Remove odd values: a is now [2]
a.reject! {|x| x%2==0}   # Like delete_if: a is now []
 
# Removing elements and subarrays with slice!
a = [1,2,3,4,5,6,7,8]
a.slice!(0)        # => 1: remove element 0: a is [2,3,4,5,6,7,8]
a.slice!(-1,1)     # => [8]: remove subarray at end: a is [2,3,4,5,6,7]
a.slice!(2..3)     # => [4,5]: works with ranges: a is [2,3,6,7]
a.slice!(4,2)      # => []: empty array just past end: a unchanged
a.slice!(5,2)      # => nil: a now holds [2,3,6,7,nil]!

# Replacing subarrays with []=
# To delete, assign an empty array
# To insert, assign to a zero-width slice
a = ('a'..'e').to_a    # => ['a','b','c','d','e']
a[0,2] = ['A','B']     # a now holds ['A', 'B', 'c', 'd', 'e']
a[2...5]=['C','D','E'] # a now holds ['A', 'B', 'C', 'D', 'E']
a[0,0] = [1,2,3]       # Insert elements at the beginning of a
a[0..2] = []           # Delete those elements
a[-1,1] = ['Z']        # Replace last element with another
a[-1,1] = 'Z'          # For single elements, the array is optional
a[1,4] = nil           # Ruby 1.9: a now holds ['A',nil]
                       # Ruby 1.8: a now holds ['A']: nil works like []

# Other methods
a = [4,5]
a.replace([1,2,3])     # a now holds [1,2,3]: a copy of its argument
a.fill(0)              # a now holds [0,0,0]
a.fill(nil,1,3)        # a now holds [0,nil,nil,nil]
a.fill('a',2..4)       # a now holds [0,nil,'a','a','a']
a[3].upcase!           # a now holds [0,nil,'A','A','A']
a.fill(2..4) { 'b' }   # a now holds [0,nil,'b','b','b']
a[3].upcase!           # a now holds [0,nil,'b','B','b']
a.compact              # => [0,'b','B','b']: copy with nils removed
p a.compact!             # Remove nils in place: a now holds [0,'b','B','b']
p a.clear                # a now holds []

puts '-------------------'

a = ['a','b','c']
a.each {| elt| print elt }         # The basic each iterator prints "abc"
a.reverse_each {|e| print e}       # Array-specific: prints "cba" 
# a.cycle {|e| print e }             # Ruby 1.9: prints "abcabcabc..." forever
a.each_index {|i| print i}         # Array-specific: prints "012"
a.each_with_index{|e,i| print e,i} # Enumerable: prints "a0b1c2"
a.map {|x| x.upcase}               # Enumerable: returns ['A','B','C']
a.map! {|x| x.upcase}              # Array-specific: alters a in place
a.collect! {|x| x.downcase!}       # collect! is synonym for map!

# Searching methods
a = %w[h e l l o]
a.include?('e')                    # => true
a.include?('w')                    # => false
a.index('l')                       # => 2: index of first match
a.index('L')                       # => nil: no match found
a.rindex('l')                      # => 3: search backwards
a.index {|c| c =~ /[aeiou]/}       # => 1: index of first vowel. Ruby 1.9.
a.rindex {|c| c =~ /[aeiou]/}      # => 4: index of last vowel. Ruby 1.9.

# Sorting
a.sort     # => %w[e h l l o]: copy a and sort the copy
a.sort!    # Sort in place: a now holds ['e','h','l','l','o']
a = [1,2,3,4,5]               # A new array to sort into evens and odds
p a.sort! {|a,b| a%2 <=> b%2}   # Compare elements modulo 2

# Shuffling arrays: the opposite of sorting; Ruby 1.9 only
a = [1,2,3]     # Start ordered
p a.shuffle  # Shuffle randomly. E.g.: [3,1,2]. Also shuffle!

puts '-------------------'

p [1,3,5] & [1,2,3]           # => [1,3]: set intersection
p [1,1,3,5] & [1,2,3]         # => [1,3]: duplicates removed
p [1,3,5] | [2,4,6]           # => [1,3,5,2,4,6]: set union
[1,3,5,5] | [2,4,6,6]       # => [1,3,5,2,4,6]: duplicates removed
[1,2,3] - [2,3]             # => [1]: set difference
[1,1,2,2,3,3] - [2, 3]      # => [1,1]: not all duplicates removed

p even = (0..50).map {|x| x*2}  # A set of even numbers
smalleven = small & even    # Set intersection
smalleven.include?(8)       # => true: test for set membership

p [1, 1, nil, nil].uniq       # => [1, nil]: remove dups. Also uniq!

puts '-------------------'

a = [1,2,3]

# Iterate all possible 2-element subarrays (order matters)
a.permutation(2) {|x| p x }  # Prints "[1,2][1,3][2,1][2,3][3,1][3,2]"

puts '-------------------'

# Iterate all possible 2-element subsets (order does not matter)
a.combination(2) {|x| p x }  # Prints "[1, 2][1, 3][2, 3]"

# Return the Cartesian product of the two sets
p a.product(['a','b'])       # => [[1,"a"],[1,"b"],[2,"a"],[2,"b"],[3,"a"],[3,"b"]]

puts '-------------------'

p [1,2].product([3,4],[5,6]) # => [[1,3,5],[1,3,6],[1,4,5],[1,4,6], etc... ] 

puts '-------------------'

h = { :a => 1, :b => 2}   # Start with a hash
a = h.to_a                # => [[:b,2], [:a,1]]: associative array
p a.assoc(:a)               # => [:a,1]: subarray for key :a
a.assoc(:b).last          # => 2: value for key :b
p a.rassoc(1)               # => [:a,1]: subarray for value 1
p a.rassoc(2).first         # => :b: key for value 2
p a.assoc(:c)               # => nil
a.transpose               # => [[:a, :b], [1, 2]]: swap rows and cols

puts '-------------------'

puts :a=>1, :b=>2

h = { :a => 1, :b => 2 }
# Checking for the presence of keys in a hash: fast
h.key?(:a)       # true: :a is a key in h
h.has_key?(:b)   # true: has_key? is a synonym for key?
h.include?(:c)   # false: include? is another synonym
h.member?(:d)    # false: member? is yet another synonym

# Checking for the presence of values: slow
h.value?(1)      # true: 1 is a value in h
h.has_value?(3)  # false: has_value? is a synonym for value?

puts '-------------------'

p ({:a=>1, :b=>2}.merge(:a=>3, :c=>3))

# update is a synonym for merge!
h = {:a=>1,:b=>2}     # Using Ruby 1.9 syntax and omitting braces
p h.update(:b=>4, :c=>9) {|key,old,new| old }  # h is now {a:1, b:2, c:9}
p h.update(:b=>4, :c=>9) # h is now {a:1, b:4, c:9}

puts '-------------------'

h = {:a=>1, :b=>2, :c=>3, :d=>"four"}
h.reject! {|k,v| v.is_a? String }  # => {:a=>1, :b=>2, :c=>3 }
h.delete_if {|k,v| k.to_s < 'b' }  # => {:b=>2, :c=>3 }
h.reject! {|k,v| k.to_s < 'b' }    # => nil: no change
h.delete_if {|k,v| k.to_s < 'b' }  # => {:b=>2, :c=>3 }: unchanged hash
h.reject {|k,v| true }             # => {}: h is unchanged

puts '-------------------'

h = { :a=>1, :b=>2, :c=>3 }
# Size of hash: number of key/value pairs
h.length     # => 3
h.size       # => 3: size is a synonym for length
h.empty?     # => false
{}.empty?    # => true

h.keys       # => [:b, :c, :a]: array of keys
h.values     # => [2,3,1]: array of values
h.to_a       # => [[:b,2],[:c,3],[:a,1]]: array of pairs
p h.sort {|a,b| a[1]<=>b[1] } # Sort pairs by value instead of key

puts '-------------------'

h = { :a=>1, :b=>2, :c=>3 }

# The each() iterator iterates [key,value] pairs
h.each {|pair| print pair }    # Prints "[:a, 1][:b, 2][:c, 3]"
puts ''
# It also works with two block arguments
h.each do |key, value|                
  print "#{key}:#{value} "     # Prints "a:1 b:2 c:3" 
end
puts ''
# Iterate over keys or values or both
h.each_key {|k| print k }      # Prints "abc"
puts ''
h.each_value {|v| print v }    # Prints "123"
puts ''
h.each_pair {|k,v| print k,v } # Prints "a1b2c3". Like each
puts '','-------------------'

empty = Hash.new(-1)   # Specify a default value when creating hash
p empty["one"]           # => -1
empty.default = -2     # Change the default value to something else
p empty["two"]           # => -2
empty.default          # => -2: return the default value

puts '-------------------'

# If the key is not defined, return the successor of the key.
plus1 = Hash.new {|hash, key| key.succ }
plus1[1]      # 2
plus1["one"]  # "onf": see String.succ
plus1.default_proc  # Returns the Proc that computes defaults
p plus1.default(10)   # => 11: default returned for key 10

puts '-------------------'

# This lazily initialized hash maps integers to their factorials
fact = Hash.new {|h,k| h[k] = if k > 1 then k*h[k-1] else 1 end }
fact      # {}: it starts off empty
fact[4]   # 24: 4! is 24
p fact      # {1=>1, 2=>2, 3=>6, 4=>24}: the hash now has entries

puts '-------------------'

h = {:a=>1, :b=>2}
p h.invert 







