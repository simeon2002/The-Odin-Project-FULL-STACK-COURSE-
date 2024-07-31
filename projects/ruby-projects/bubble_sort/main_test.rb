class MyCar
  attr_accessor :year, :color, :model, :speed

  def initialize (year, color, model)
    self.year = year
    self.color = color
    self.model = model
    self.speed = 0
  end

  def accelerate
    self.speed += 5
  end

  def decelerate
    self.speed -= 5
  end

  def shut_off
    self.speed = 0
  end
end

new_car = MyCar.new 2010, "blue", "sedane"
p new_car.speed
p new_car.accelerate
p new_car.accelerate
p new_car.decelerate
new_car.shut_off
p new_car.speed

p new_car.hash
p new_car
puts new_car
