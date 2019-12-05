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

## Day 3

### Part 1

I decided with day 3 to try and actually design the system from the outset, rather than my usual _stream of thought_ method. Partly as an exercise in software design, but I also wanted to try and build core functionality that would require no modifications when part 2 was revealed.

With that in mind my code:

 - Supports more (or less) than two wire runs (`Path`s)
 - Uses a traversable linked-list type structure for the paths, instead of just being cells on a grid
 - Is able to output the grid to the terminal

At one point I also had a class factory and dependency injection involved, so I did dial it back a little bit. I definitely could have done better, like not having all my classes in one file, but ain't no body got time for that.

This one took me a _long_ time (3 - 4 hours ish), partly because (at least in my opinion) it's just difficult. But also because at first I didn't notice the instruction saying that it doesn't count as an intersection when a wire crosses itself.

I'm glad I built the functionality to display the grid, as that was really useful in debugging.

### Part 2

I _almost_ succeeded in not needing to modify part 1's classes. Part two required traversing the paths, so my list structure was a good choice. I did need to make a slight change as originally I was storing whether a cell was an intersection as a boolean `is_intersection`, but I actually needed to know which cell it intersected with, so I modified that to be `intersects_with` which references another cell.

Thanks in part to the time I invested in part 1, this only took me about 20 minutes, so that was pretty cool.

## Day 4

### Part 1 and 2

For me, day for seemed like a big drop in difficultly over day 3, I was able to get both parts done with a few lines of Ruby in about 10 minutes. Not much else to say about this one.

There's definitely some redundant code in part 2, as I just copy/pasted part one, and added a new rule, instead of modifying the part one rules.

