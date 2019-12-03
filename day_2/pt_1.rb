input = File.read("input")
intcode = input.split("\,").map(&:to_i)
intcode[1] = 12
intcode[2] = 2


def run(intcode, pos=0)
  cmd = intcode[pos]

  return if cmd.nil? || cmd == 99

  param1 = intcode[intcode[pos+1]]
  param2 = intcode[intcode[pos+2]]
  output_pos = intcode[pos+3]

  case cmd
  when 1
    intcode[output_pos] = param1 + param2
  when 2
    intcode[output_pos] = param1 * param2
  end

  run(intcode, pos+4)
end

run(intcode)

p intcode[0]