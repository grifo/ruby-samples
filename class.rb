class Vehicle
    attr_accessor :color, :size
    @@num = 0

    def initialize (color = "black", size = 100)
        @color = color
        @size = size

        @@num += 1
    end

    def is_black?
        @color == "black"
    end

    def self.num
        @@num
    end

    def method_missing(m, *args, &block)
        "Sorry, \"#{m}\" are no present"
    end
end

class Car < Vehicle
    def initialize (color = "black", size = 100, doors = 5)
        super color, size
        doors = doors
    end

    def is_black?
        @color == "grey" or super
    end
end


# --- Javascript ---
# 
# Vehicle.prototype.initialize
# Vehicle.num = 3

# 
# class Car < Vehicle
#     def initialize 
# end
# 

car = Car.new "black"
car1 = Car.new "grey"
car2 = Car.new "green"
car3 = Car.new "green"

veh = Vehicle.new "green"

# p Vehicle::num

puts car3.run()

# p car.is_black?
# p car1.is_black?

# p car.color

# car.color = "grey"
# p car.color
# p car.size




