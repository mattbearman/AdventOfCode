load "classes.rb"
input = File.read("input.txt")

space = Space.new(orbit_map: input)

p space.orbit_count

