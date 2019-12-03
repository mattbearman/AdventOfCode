def fuel_for_fuel(mass)
  fuel_req = [(mass.to_i / 3).floor - 2, 0].max

  if fuel_req > 0
    fuel_req += fuel_for_fuel(fuel_req)
  end

  fuel_req
end

input = File.open("input")
p input.readlines.reduce(0) { | total_mass, module_mass | total_mass + fuel_for_fuel(module_mass) }
input.close
