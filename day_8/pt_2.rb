load "classes.rb"
input = File.read("input.txt")

i = SpaceImage.new(raw_data: input, width: 25, height: 6)

print i.render
