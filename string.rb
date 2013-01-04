s = "hello"
p s.concat(" world")    # Synonym for <<. Mutating append to s. Returns new s.
p s.insert(5, " there") # Same as s[5] = " there". Alters s. Returns new s.
p s.slice(0,5)          # Same as s[0,5]. Returns a substring.
p s.slice!(5,6)         # Deletion. Same as s[5,6]="". Returns deleted substring.
p s.eql?("hello world") # True. Same as ==.

p s.length         # => 5: counts characters in 1.9, bytes in 1.8
p s.size           # => 5: size is a synonym
p s.bytesize       # => 5: length in bytes; Ruby 1.9 only
p s.empty?         # => false
p "".empty?        # => true

s = "hello"
# Finding the position of a substring or pattern match
p s.index('l')         # => 2: index of first l in string
p s.index(?l)          # => 2: works with character codes as well
p s.index(/l+/)        # => 2: works with regular expressions, too
p s.index('l',3)       # => 3: index of first l in string at or after position 3
p s.index('Ruby')      # => nil: search string not found
p s.rindex('l')        # => 3: index of rightmost l in string
p s.rindex('l',2)      # => 2: index of rightmost l in string at or before 2

# Checking for prefixes and suffixes: Ruby 1.9 and later
p s.start_with? "hell" # => true.  Note singular "start" not "starts"
p s.end_with? "bells"  # => false

# Testing for presence of substring
p s.include?("ll")     # => true: "hello" includes "ll"
p s.include?(?H)       # => false: "hello" does not include character H

# Pattern matching with regular expressions
p s =~ /[aeiou]{2}/    # => nil: no double vowels in "hello"
p s.match(/[aeiou]/) {|m| m.to_s} # => "e": return first vowel

# Splitting a string into substrings based on a delimiter string or pattern
p "this is it".split     # => ["this", "is", "it"]: split on spaces by default
p "hello".split('l')     # => ["he", "", "o"]
p "1, 2,3".split(/\s*,\s*/) # => ["1","2","3"]: comma and optional space delimiter

# Split a string into two parts plus a delimiter. Ruby 1.9 only.
# These methods always return arrays of 3 strings:
p "banana".partition("an")  # => ["b", "an", "ana"] 
p "banana".rpartition("an") # => ["ban", "an", "a"]: start from right
p "a123b".partition(/\d+/)  # => ["a", "123", "b"]: works with Regexps, too

# Search and replace the first (sub, sub!) or all (gsub, gsub!)
# occurrences of the specified string or pattern.
# More about sub and gsub when we cover regular expressions later.
p s.sub("l", "L")            # => "heLlo": Just replace first occurrence
p s.gsub("l", "L")           # => "heLLo": Replace all occurrences
p s.sub!(/(.)(.)/, '\2\1')   # => "ehllo": Match and swap first 2 letters
p s.sub!(/(.)(.)/, "\\2\\1") # => "hello": Double backslashes for double quotes

# sub and gsub can also compute a replacement string with a block
# Match the first letter of each word and capitalize it
p "hello world".gsub(/\b./) {|match| p match; match.upcase } # => "Hello World"


# Case modification methods
s = "world"   # These methods work with ASCII characters only
s.upcase      # => "WORLD"
s.upcase!     # => "WORLD"; alter s in place
s.downcase    # => "world"
s.capitalize  # => "World": first letter upper, rest lower
s.capitalize! # => "World": alter s in place
s.swapcase    # => "wORLD": alter case of each letter

# Case insensitive comparison. (ASCII text only)
# casecmp works like <=> and returns -1 for less, 0 for equal, +1 for greater
p "world".casecmp("WORLD")  # => 0 
p "a".casecmp("B")          # => -1 (<=> returns 1 in this case)

s = "hello\r\n"      # A string with a line terminator
p s.chomp!             # => "hello": remove one line terminator from end
p s.chomp              # => "hello": no line terminator so no change
p s.chomp!             # => nil: return of nil indicates no change made
p s.chomp("o")         # => "hell": remove "o" from end
$/ = ";"             # Set global record separator $/ to semicolon
"hello;".chomp       # => "hello": now chomp removes semicolons and end

# chop removes trailing character or line terminator (\n, \r, or \r\n)
s = "hello\n"
s.chop!              # => "hello": line terminator removed. s modified.
s.chop               # => "hell": last character removed. s not modified.
"".chop              # => "": no characters to remove
"".chop!             # => nil: nothing changed

# Strip all whitespace (including \t, \r, \n) from left, right, or both
# strip!, lstrip! and rstrip! modify the string in place.
s = "\t hello \n"   # Whitespace at beginning and end
s.strip             # => "hello"
s.lstrip            # => "hello \n"
s.rstrip            # => "\t hello"

# Left-justify, right-justify, or center a string in a field n-characters wide.
# There are no mutator versions of these methods. See also printf method.
s = "x"
s.ljust(3)          # => "x  "
s.rjust(3)          # => "  x"
p s.center(3)         # => " x "
p s.center(5, '-')    # => "--x--": padding other than space are allowed
p s.center(7, '-=')   # => "-=-x-=-": multicharacter padding allowed



s = "A\nB"                       # Three ASCII characters on two lines
s.each_byte {|b| print b, " " }  # Prints "65 10 66 "
puts '-'
s.each_line {|l| print l.chomp}  # Prints "AB"
puts '-'
# Sequentially iterate characters as 1-character strings
# Works in Ruby 1.9, or in 1.8 with the jcode library:
s.each_char { |c| print c, " " } # Prints "A \n B "
puts '-'
# Enumerate each character as a 1-character string
# This does not work for multibyte strings in 1.8
# It works (inefficiently) for multibyte strings in 1.9:
0.upto(s.length-1) {|n| print s[n,1], " "}
puts '-'
# In Ruby 1.9, bytes, lines, and chars are aliases
p s.bytes.to_a                     # => [65,10,66]: alias for each_byte
p s.lines.to_a                     # => ["A\n","B"]: alias for each_line
p s.chars.to_a                     # => ["A", "\n", "B"] alias for each_char




"10".to_i          # => 10: convert string to integer
"10".to_i(2)       # => 2: argument is radix: between base-2 and base-36
"10x".to_i         # => 10: nonnumeric suffix is ignored. Same for oct, hex
" 10".to_i         # => 10: leading whitespace ignored
"ten".to_i         # => 0: does not raise exception on bad input
"10".oct           # => 8: parse string as base-8 integer
"10".hex           # => 16: parse string as hexadecimal integer
"0xff".hex         # => 255: hex numbers may begin with 0x prefix
" 1.1 dozen".to_f  # => 1.1: parse leading floating-point number
"6.02e23".to_f     # => 6.02e+23: exponential notation supported

p "one".to_sym       # => :one -- string to symbol conversion
"two".intern       # => :two -- intern is a synonym for to_sym



# Increment a string:
"a".succ                      # => "b": the successor of "a". Also, succ!
"aaz".next                    # => "aba": next is a synonym. Also, next!
"a".upto("e") {|c| print c }  # Prints "abcde. upto iterator based on succ.

# Reverse a string:
"hello".reverse     # => "olleh". Also reverse!

# Debugging
"hello\n".dump      # => "\"hello\\n\"": Escape special characters
"hello\n".inspect   # Works much like dump

# Translation from one set of characters to another
"hello".tr("aeiou", "AEIOU")  # => "hEllO": capitalize vowels. Also tr!
"hello".tr("aeiou", " ")      # => "h ll ": convert vowels to spaces
"bead".tr_s("aeiou", " ")     # => "b d": convert and remove duplicates

# Checksums
"hello".sum          # => 532: weak 16-bit checksum
"hello".sum(8)       # => 20: 8 bit checksum instead of 16 bit
"hello".crypt("ab")  # => "abl0JrMf6tlhw": one way cryptographic checksum
                     # Pass two alphanumeric characters as "salt"
                     # The result may be platform-dependent

# Counting letters, deleting letters, and removing duplicates
"hello".count('aeiou')  # => 2: count lowercase vowels
"hello".delete('aeiou') # => "hll": delete lowercase vowels. Also delete!
"hello".squeeze('a-z')  # => "helo": remove runs of letters. Also squeeze!
# When there is more than one argument, take the intersection.
# Arguments that begin with ^ are negated.
"hello".count('a-z', '^aeiou')   # => 3: count lowercase consonants
"hello".delete('a-z', '^aeiou')  # => "eo: delete lowercase consonants


puts '------------------------'


n, animal = 2, "mice"
p '%d blind %s' % [n+1, animal]

# Formatting numbers
'%d' % 10         # => '10': %d for decimal integers
'%x' % 10         # => 'a': hexadecimal integers
'%X' % 10         # => 'A': uppercase hexadecimal integers
'%o' % 10         # => '12': octal integers
'%f' % 1234.567   # => '1234.567000': full-length floating-point numbers
'%e' % 1234.567   # => '1.234567e+03': force exponential notation
'%E' % 1234.567   # => '1.234567e+03': exponential with uppercase E
'%g' % 1234.567   # => '1234.57': six significant digits
'%g' % 1.23456E12 # => '1.23456e+12': Use %f or %e depending on magnitude

# Field width
'%5s' % '<<<'     # '  <<<': right-justify in field five characters wide
'%-5s' % '>>>'    # '>>>  ': left-justify in field five characters wide
'%5d' % 123       # '  123': field is five characters wide
'%05d' % 123      # '00123': pad with zeros in field five characters wide

# Precision
'%.2f' % 123.456  # '123.46': two digits after decimal place
'%.2e' % 123.456  # '1.23e+02': two digits after decimal = three significant digits
'%.6e' % 123.456  # '1.234560e+02': note added zero 
'%.4g' % 123.456  # '123.5': four significant digits

# Field and precision combined
'%6.4g' % 123.456 # ' 123.5': four significant digits in field six chars wide
'%3s' % 'ruby'    # 'ruby': string argument exceeds field width
'%3.3s' % 'ruby'  # 'rub': precision forces truncation of string

# Multiple arguments to be formatted
args = ['Syntax Error', 'test.rb', 20]  # An array of arguments
"%s: in '%s' line %d" % args    # => "Syntax Error: in 'test.rb' line 20" 
# Same args, interpolated in different order!  Good for internationalization.
"%2$s:%3$d: %1$s" % args        # => "test.rb:20: Syntax Error"



a = [1,2,3,4,5,6,7,8,9,10]  # An array of 10 integers
b = a.pack('i10')           # Pack 10 4-byte integers (i) into binary string b
c = b.unpack('i*')          # Decode all (*) the 4-byte integers from b
c == a                      # => true

m = 'hello world'           # A message to encode
data = [m.size, m]          # Length first, then the bytes
template = 'Sa*'            # Unsigned short, any number of ASCII chars
b = data.pack(template)     # => "\v\000hello world"
b.unpack(template)          # => [11, "hello world"]







