load "classes.rb"
input = File.read("input.txt")

i = SpaceImage.new(raw_data: input, width: 25, height: 6)

l = i.layer_with_fewest(0)

p l.digit_count(1) * l.digit_count(2)
