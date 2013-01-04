# i   	  Ignore case when matching text.
# m 	    The pattern is to be matched against multiline text, so treat newline as an ordinary character: allow . to match newlines.
# x 	    Extended syntax: allow whitespace and comments in regexp.
# o 	    Perform #{} interpolations only once, the first time the regexp literal is evaluated.
# u,e,s,n	Interpret the regexp as Unicode (UTF-8), EUC, SJIS, or ASCII. If none of these modifiers is specified, the regular expression is assumed to use the source encoding. 

%r|/|         # Matches a single slash character, no escape required

p '</opa>'.match %r[</(.*)>]i  # Flag characters are allowed with this syntax, too

money = /[$\u20AC\u{a3}\u{a5}]/ # match dollar,euro,pound, or yen sign

pattern = "[a-z]+"                # One or more letters
suffix = Regexp.escape("()")      # Treat these characters literally
r = Regexp.new(pattern + suffix)  # /[a-z]+\(\)/


# Literal characters
/ruby/             # Match "ruby". Most characters simply match themselves.
/¥/                # Matches Yen sign. Multibyte characters are suported
                   # in Ruby 1.9 and Ruby 1.8.

# Character classes
/[Rr]uby/          # Match "Ruby" or "ruby"
/rub[ye]/          # Match "ruby" or "rube"
/[aeiou]/          # Match any one lowercase vowel
/[0-9]/            # Match any digit; same as /[0123456789]/
/[a-z]/            # Match any lowercase ASCII letter
/[A-Z]/            # Match any uppercase ASCII letter
/[a-zA-Z0-9]/      # Match any of the above
/[^aeiou]/         # Match anything other than a lowercase vowel
/[^0-9]/           # Match anything other than a digit

# Special character classes
/./                # Match any character except newline
/./m               # In multiline mode . matches newline, too
/\d/               # Match a digit /[0-9]/
/\D/               # Match a nondigit: /[^0-9]/
/\s/               # Match a whitespace character: /[ \t\r\n\f]/
/\S/               # Match nonwhitespace: /[^ \t\r\n\f]/
/\w/               # Match a single word character: /[A-Za-z0-9_]/
/\W/               # Match a nonword character: /[^A-Za-z0-9_]/

# Repetition
/ruby?/            # Match "rub" or "ruby": the y is optional
/ruby*/            # Match "rub" plus 0 or more ys
/ruby+/            # Match "rub" plus 1 or more ys
/\d{3}/            # Match exactly 3 digits
/\d{3,}/           # Match 3 or more digits
/\d{3,5}/          # Match 3, 4, or 5 digits

# Nongreedy repetition: match the smallest number of repetitions
/<.*>/             # Greedy repetition: matches "<ruby>perl>"
/<.*?>/            # Nongreedy: matches "<ruby>" in "<ruby>perl>" 
                   # Also nongreedy: ??, +?, and {n,m}?

# Grouping with parentheses
/\D\d+/            # No group: + repeats \d
/(\D\d)+/          # Grouped: + repeats \D\d pair
/([Rr]uby(, )?)+/  # Match "Ruby", "Ruby, ruby, ruby", etc.

# Backreferences: matching a previously matched group again
/([Rr])uby&\1ails/ # Match ruby&rails or Ruby&Rails
/(['"])[^\1]*\1/   # Single or double-quoted string
                   #   \1 matches whatever the 1st group matched
                   #   \2 matches whatever the 2nd group matched, etc.

# Alternatives
/ruby|rube/        # Match "ruby" or "rube"
/rub(y|le)/       # Match "ruby" or "ruble"
/ruby(!+|\?)/      # "ruby" followed by one or more ! or one ?

# Anchors: specifying match position
/^Ruby/            # Match "Ruby" at the start of a string or internal line
/Ruby$/            # Match "Ruby" at the end of a string or line
/\ARuby/           # Match "Ruby" at the start of a string
/Ruby\Z/           # Match "Ruby" at the end of a string
/\bRuby\b/         # Match "Ruby" at a word boundary
/\brub\B/          # \B is nonword boundary:
                   #   match "rub" in "rube" and "ruby" but not alone
/Ruby(?=!)/        # Match "Ruby", if followed by an exclamation point
/Ruby(?!!)/        # Match "Ruby", if not followed by an exclamation point

# Special syntax with parentheses
/R(?#comment)/     # Matches "R". All the rest is a comment
/R(?i)uby/         # Case-insensitive while matching "uby"
/R(?i:uby)/        # Same thing
/rub(?:y|le)/     # Group only without creating \1 backreference

# The x option allows comments and ignores whitespace
/  # This is not a Ruby comment. It is a literal part
   # of the regular expression, but is ignored.
   R      # Match a single letter R
   (uby)+ # Followed by one or more "uby"s
   \      # Use backslash for a nonignored space
/x                 # Closing delimiter. Don't forget the x option!



p '------------------------'


pattern = /Ruby?/i      # Match "Rub" or "Ruby", case-insensitive
p pattern =~ "backrub"    # Returns 4.
p "rub ruby" =~ pattern   # 0
p pattern =~ "r"          # nil

"hello" =~ /e\w{2}/     # 1: Match an e followed by 2 word characters
$~.string               # "hello": the complete string
$~.to_s                 # "ell": the portion that matched
$~.pre_match            # "h": the portion before the match
$~.post_match           # "o": the portion after the match


p Regexp.last_match == $~ ## TRUE


# This is a pattern with three subpatterns
pattern = /(Ruby|Perl)(\s+)(rocks|sucks)!/ 
text = "Ruby\trocks!"     # Text that matches the pattern    
pattern =~ text           # => 0: pattern matches at the first character
data = Regexp.last_match  # => Get match details
data.size                 # => 4: MatchData objects behave like arrays
data[0]                   # => "Ruby\trocks!": the complete matched text
data[1]                   # => "Ruby": text matching first subpattern
data[2]                   # => "\t": text matching second subpattern
data[3]                   # => "rocks": text matching third subpattern
data[1,2]                 # => ["Ruby", "\t"]
data[1..3]                # => ["Ruby", "\t", "rocks"]
data.values_at(1,3)       # => ["Ruby", "rocks"]: only selected indexes
data.captures             # => ["Ruby", "\t", "rocks"]: only subpatterns
Regexp.last_match(3)      # => "rocks": same as Regexp.last_match[3]

# Start and end positions of matches
data.begin(0)             # => 0: start index of entire match
data.begin(2)             # => 4: start index of second subpattern
data.end(2)               # => 5: end index of second subpattern
data.offset(3)            # => [5,10]: start and end of third subpattern



# $~  	    $LAST_MATCH_INFO  	 Regexp.last_match
# $& 	      $MATCH 	             Regexp.last_match[0]
# $` 	      $PREMATCH 	         Regexp.last_match.pre_match
# $' 	      $POSTMATCH 	         Regexp.last_match.post_match
#  $1 	    none	               Regexp.last_match[1]
# $2, etc.	none	               Regexp.last_match[2], etc.
# $+ 	      $LAST_PAREN_MATCH 	 Regexp.last_match[-1]


"ruby123"[/\d+/]              # "123"
"ruby123"[/([a-z]+)(\d+)/, 1]  # "ruby"
"ruby123"[/([a-z]+)(\d+)/, 2]  # "123"


"one, two, three".split(/\s*,\s*/) # ["one","two","three"]: space is optional around comma

phone = "3213 #sd"                    # Read a phone number
phone.sub!(/#.*$/, "")          # Delete Ruby-style comments          %%  JUST ONE
phone.gsub!(/\D/, "")           # Remove anything other than digits   %%  ALL


text.gsub(/\bruby\b/i, "<b>#{$&}</b>")


text = "RUBY Java perl PyThOn % Isso FiCa CoMo TaH"         # Text to modify
lang = /ruby|java|perl|python/i        # Pattern to match
text.gsub!(lang) {|l| l.capitalize }   # Fix capitalization

p text



