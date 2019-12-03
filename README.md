# AdventOfCode

## Day 1

### Part 1

I had a stab at this one while laying in bed on Sunday morning, so in the spirit of laziness, I just opened up the developer console and did it in Javascript, and pasted the input in as a multi-line string.

I got it wrong the first couple of times, as I forgot how `reduce` works in Javascript:

 - First I didn't set the first item in the input array to 0 - fixed with `input.unshift(0);` in the code
 - I also forgot to add the result of each iteration to the accumulator in `reduce`

### Part 2

For this one I actually bothered to use Ruby, and just hacked together a simple recursive function to calculate the fuel required for the fuel (and the fuel for the fuel for the fuel...)

## Day 2

### Part 1

Sticking with Ruby, I attacked this one with what I call _"stream of thought"_ programming, ie: no planning or consideration to structure or patterns. I find this works well for spiking out a new idea, and usually creates small, though messy, code.

### Part 2

For part 2 I tried to do write better code, creating a more universal computer class, and a separate brute force script.

My first instinct on seeing this puzzle was to avoid brute force, but I couldn't think of a better method, and I'm not someone who has a lot of free time ¯\\\_(ツ)\_/¯