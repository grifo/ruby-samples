# Creating Time objects
p Time.now        # Returns a time object that represents the current time
Time.new        # A synonym for Time.now

Time.local(2007, 7, 8)          # July 8, 2007
Time.local(2007, 7, 8, 9, 10)   # July 8, 2007, 09:10am, local time
Time.utc(2007, 7, 8, 9, 10)     # July 8, 2007, 09:10 UTC
Time.gm(2007, 7, 8, 9, 10, 11)  # July 8, 2007, 09:10:11 GMT (same as UTC)

# One microsecond before the new millennium began in London
# We'll use this Time object in many examples below.
t = Time.utc(2000, 12, 31, 23, 59, 59, 999999)

p t.year    # => 2000
p t.month   # => 12: December
p t.day     # => 31
p t.wday    # => 0: day of week: 0 is Sunday
p t.yday    # => 366: day of year: 2000 was a leap year
p t.hour    # => 23: 24-hour clock
p t.min     # => 59
p t.sec     # => 59
p t.usec    # => 999999: microseconds, not milliseconds
p t.zone    # => "UTC": timezone name

# [sec,min,hour,day,month,year,wday,yday,isdst,zone]
p t.to_a

p t.localtime

# strftime interpolates date and time components into a template string
# Locale-independent formatting
t.strftime("%Y-%m-%d %H:%M:%S") # => "2000-12-31 23:59:59": ISO-8601 format
t.strftime("%H:%M")             # => "23:59": 24-hour time
t.strftime("%I:%M %p")          # => "11:59 PM": 12-hour clock

# Locale-dependent formats
t.strftime("%A, %B %d")         # => "Sunday, December 31"
t.strftime("%a, %b %d %y")      # => "Sun, Dec 31 00": 2-digit year
t.strftime("%x")                # => "12/31/00": locale-dependent format
t.strftime("%X")                # => "23:59:59"
t.strftime("%c")                # same as ctime

# Parsing Times and Dates
require 'parsedate'    # A versatile date/time parsing library
include ParseDate      # Include parsedate() as a global function
datestring = "2001-01-01"
values = parsedate(datestring)  # [2001, 1, 1, nil, nil, nil, nil, nil]
t = Time.local(*values)         # => Mon Jan 01 00:00:00 -0800 2001
s = t.ctime                     # => "Mon Jan  1 00:00:00 2001"
Time.local(*parsedate(s))==t    # => true

s = "2001-01-01 00:00:00-0500"  # midnight in New York
v = parsedate(s)                # => [2001, 1, 1, 0, 0, 0, "-0500", nil]
t = Time.local(*v)              # Loses time zone information!

# Time arithmetic
now = Time.now          # Current time
past = now - 10         # 10 seconds ago. Time - number => Time
future = now + 10       # 10 seconds from now Time + number => Time
future - now            # => 10  Time - Time => number of seconds

# Time comparisons
past <=> future         # => -1
past < future           # => true
now >= future           # => false
now == now              # => true

