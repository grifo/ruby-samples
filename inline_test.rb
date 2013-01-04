require "rubygems"
require "inline"


class << self
  inline do |builder|
    #builder.add_compile_flags '-fasm-blocks'
    builder.c "
      int sum(int num1, int num2) {
        return num1 + num2;
      }
    "
  end
end

puts sum(2, 3)
