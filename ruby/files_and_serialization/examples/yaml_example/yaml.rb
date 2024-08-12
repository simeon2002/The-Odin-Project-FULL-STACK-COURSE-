require 'yaml'
require 'debug'

# p File.read('test.yaml')
yaml_content =YAML.load(File.read('test.yaml'))
# debugger
p YAML.dump("name" => "Simeon")


require 'yaml'

class Person
  attr_accessor :name, :age, :gender

  def initialize(name, age, gender)
    @name = name
    @age = age
    @gender = gender
  end

  def to_yaml
    YAML.dump ({
      :name => @name,
      :age => @age,
      :gender => @gender
    })
  end

  def self.from_yaml(string)
    data = YAML.load string
    p data
    self.new(data[:name], data[:age], data[:gender])
  end
end

p = Person.new "David", 28, "male"
p p.to_yaml

p = Person.from_yaml(p.to_yaml)
puts "Name #{p.name}"
puts "Age #{p.age}"
puts "Gender #{p.gender}"
