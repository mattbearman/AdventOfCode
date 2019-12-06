class Space
  attr_reader :orbit_map
  attr_accessor :objects

  def initialize(orbit_map:)
    @orbit_map = orbit_map
    @objects = {}
    populate
  end

  def populate
    orbit_map.lines.each do | orbit |
      add_orbit(orbit: orbit)
    end
  end

  def add_orbit(orbit:)
    orbits, orbiter = orbit.chomp.split(")").map do | object_id |
      find_or_create_object(identifier: object_id)
    end

    orbiter.orbits = orbits
  end

  def find_or_create_object(identifier:)
    objects[identifier] ||= Space::Object.new(id: identifier)
  end

  def orbit_count
    objects.values.map(&:orbit_count).sum
  end

  def navigate_between(from_id:, to_id:, path: [])
    from = objects[from_id]
    to = objects[to_id]

    start = from.orbits
    finish = to.orbits

    return start.navigate_to(finish)
  end
end

class Space
  class Object
    attr_accessor :orbiters
    attr_reader :id, :orbits

    def initialize(id:, orbits: nil)
      @id = id
      @orbiters = []

      self.orbits = orbits
    end

    def orbits=(orbits)
      if orbits
        @orbits = orbits
        orbits.orbiters << self
      end
    end

    def orbit_count(running_total: 1)
      return 0 if orbits.nil?

      running_total + orbits.orbit_count(running_total: running_total)
    end

    def orbited_by?(object)
      orbiters.include?(object)
    end

    def all_nodes
      ([orbits] + orbiters).compact
    end

    def navigate_to(target, searched_nodes:[])
      searched_nodes << self

      return [self.id] if target == self

      result = false

      (all_nodes - searched_nodes).each do | node |
        found_target = node.navigate_to(target, searched_nodes: searched_nodes)

        if found_target
          result = [self.id] + found_target
          break
        end
      end

      result
    end
  end
end

com = Space::Object.new(id: "com")
a = Space::Object.new(id: "a", orbits: com)
b = Space::Object.new(id: "b", orbits: a)
c = Space::Object.new(id: "c", orbits: a)
d = Space::Object.new(id: "d", orbits: c)

#          b
#         /
#  com - a
#         \
#          c - d
# 

raise "d orbit count: #{d.orbit_count} != 3" unless d.orbit_count == 3
raise "c orbit count: #{c.orbit_count} != 2" unless c.orbit_count == 2
raise "b orbit count: #{b.orbit_count} != 2" unless b.orbit_count == 2
raise "a orbit count: #{a.orbit_count} != 1" unless a.orbit_count == 1
raise "com orbit count: #{com.orbit_count} != 0" unless com.orbit_count == 0

space = Space.new(orbit_map: "COM)B
B)C
C)D
D)E
E)F
B)G
G)H
D)I
E)J
J)K
K)L")
raise "space orbit count: #{space.orbit_count} != 42" unless space.orbit_count == 42

space = Space.new(orbit_map: "COM)B
B)C
C)D
D)E
E)F
B)G
G)H
D)I
E)J
J)K
K)L
K)YOU
I)SAN")

raise "shortest path between 'YOU' and 'L' was #{space.navigate_between(from_id: "YOU", to_id: "L").length - 1}, instead of 0" unless space.navigate_between(from_id: "YOU", to_id: "L").length - 1 == 0
raise "shortest path between 'YOU' and 'E' was #{space.navigate_between(from_id: "YOU", to_id: "E").length - 1}, instead of 3" unless space.navigate_between(from_id: "YOU", to_id: "E").length - 1 == 3
raise "shortest path between 'YOU' and 'SAN' was #{space.navigate_between(from_id: "YOU", to_id: "SAN").length - 1}, instead of 4" unless space.navigate_between(from_id: "YOU", to_id: "SAN").length - 1 == 4


