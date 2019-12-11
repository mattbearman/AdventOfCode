load "complete_computer.rb"
input = File.read("input.txt")

c = CompleteComputer.new(input)
c.input = 1
c.execute
p c.output