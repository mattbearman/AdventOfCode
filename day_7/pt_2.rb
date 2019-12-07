load "amp.rb"
input = File.read("input.txt")

p PositiveFeedbackAmpSet.new(program: input).find_max_output