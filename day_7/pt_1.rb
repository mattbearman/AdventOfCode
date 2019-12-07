load "amp.rb"
input = File.read("input.txt")

output = AmpSet.new(program: input).find_max_output

raise "day 7.1 puzzle failed - output: #{output} != 79723" if output != 79723

p output
