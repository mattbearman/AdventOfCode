load "computer.rb"

input = File.read("../input")
intcode = input.split("\,").map(&:to_i)

(0..99).each do | p1 |
  (0..99).each do | p2 |
    code = intcode.dup
    code[1] = p1
    code[2] = p2
    
    c = Computer.new(code)
    c.execute

    if c.memory[0] == 19690720
      p "#{p1}, #{p2} => #{c.memory[0]}"
    end
  end
end
