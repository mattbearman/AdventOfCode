load "classes.rb"
input = File.read("input.txt")

space = Space.new(orbit_map: input)

p space.navigate_between(from_id: "YOU", to_id: "SAN").length - 1

