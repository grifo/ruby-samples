module ClassTrace
  # This array holds our list of files loaded and classes defined.
  # Each element is a subarray holding the class defined or the
  # file loaded and the stack frame where it was defined or loaded.
  T = [] # Array to hold the files loaded
  # Now define the constant OUT to specify where tracing output goes.
  # This defaults to STDERR, but can also come from command-line arguments
  if x = ARGV.index("--traceout")
    # If argument exists
    OUT = File.open(ARGV[x+1], "w") # Open the specified file
    ARGV[x,2] = nil
    # And remove the arguments
  else
    OUT = STDERR
    # Otherwise default to STDERR
  end
end
# Alias chaining step 1: define aliases for the original methods
alias original_require require
alias original_load load
# Alias chaining step 2: define new versions of the methods
def require(file)
  ClassTrace::T << [file,caller[0]]
  # Remember what was loaded where
  original_require(file)
  # Invoke the original method
end
def load(*args)
  ClassTrace::T << [args[0],caller[0]] # Remember what was loaded where
  original_load(*args)
  # Invoke the original method
end
# This hook method is invoked each time a new class is defined
def Object.inherited(c)
  ClassTrace::T << [c,caller[0]]
  # Remember what was defined where
end
# Kernel.at_exit registers a block to be run when the program exits
# We use it to report the file and class data we collected
at_exit {
  o = ClassTrace::OUT
  o.puts "="*60
  o.puts "Files Loaded and Classes Defined:"
  o.puts "="*60
  ClassTrace::T.each do |what,where|
    if what.is_a? Class # Report class (with hierarchy) defined
      o.puts "Defined: #{what.ancestors.join('<-')} at #{where}"
    else
      # Report file loaded
      o.puts "Loaded: #{what} at #{where}"
    end
  end
}








class Object
  def trace(name="", stream=STDERR)
    TracedObject.new self, name, stream
  end
end

class TracedObject
  instance_methods.each do |m|
    m = m.to_sym
    next if m == :object_id || m == :__id__ || m == :__send__
    undef_method m
  end

  def initialize(o, name, stream)
    @o = o
    @n = name
    @trace = stream
  end

  def method_missing(*args, &block)
    m = args.shift
    begin
      arglist = args.map {|a| a.inspect}.join(', ')
      @trace << "Invoking: #{@n}.#{m}(#{arglist}) at #{caller[0]}\n"
      r = @o.send m, *args, &block
      @trace << " Returning: #{r.inspect} from #{@n}.#{m} to #{caller[0]}\n"
      r
    rescue Exception => e
      @trace << "Raising: #{e.class}:#{e} from #{@n}.#{m}\n"
      #raise
    end
  end

  def __delegate
    @o
  end
end

#a = [1,2,3].trace("a")
#a.reverse
#puts a[2]
#puts a.fetch(3)

puts '-------------'

class Module
  def attributes(hash)
    hash.each_pair do |symbol, default|
      getter = symbol
      setter = :"#{symbol}="
      variable = :"@#{symbol}"
      define_method getter do
        if instance_variable_defined? variable
          instance_variable_get variable
        else
          default
        end
      end

      define_method setter do |value|
        instance_variable_set variable, value
      end
    end
  end
end


class Point
  attributes :x => 0, :y => 0
end

point = Point.new
point.x=10
p point.instance_variables

puts '-------------'

