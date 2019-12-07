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

## Day 5

### Part 1

Day 5 claims it will use the intcode computer from Day 2 with some modifications, however I (and others I've spoken to) found that the modifications to be so extensive that I found it easier just re-write the `Computer` class, rather than subclass/decorate it.

This one took me quite a while to figure out how to split the opcode from the parameter modes. I spent a lot of time fucking around with parsing and padding strings, and actually found myself getting a bit pissed off with Eric Wastl (the creator of AoC). Why the hell would he structure the codes in such a stupid way?

Eventually I realised the code format wasn't stupid, it was me that was being stupid. The codes aren't strings, they're integers. Treating them like strings was just making it much more complicated. Once that clicked, I was quickly threw a modulus based equation in, which reliably separated the opcode from the param modes, even when the param modes are implied.

Eric Wastl even did his best to make it obvious they should be treated as integers by referring to the positions as things like "the hundreds digit". So I felt a little silly for all the time I wasted. Other than that, this one wasn't too bad, except, I made a mistake in my computer, but it didn't stop it working for part 1, the error only became apparent when trying to do part 2.

### Part 2

In an unusual turn of events, part 2 seemed a lot easier than part 1, as it was just adding some new instructions. I just crated a subclass of my new `Computer` class, with the new instruction handlers. It worked through the first two of the provided examples, but then on the third test the output was nil. This is where I discovered the mistake I made in part one.

My output handler didn't handle writing to the output in immediate mode. So far every program I'd run, including the _actual_ puzzle from part 1, had only written to the output in position mode. However, in the third test script for part 2, there is the instruction `104,999` which _should_ write the value `999` to the output buffer, but in my code, it was trying to write what ever was in position 999 of the memory. Of course, there was nothing there, which is why the output was nil.

Once I'd fixed that bug, it was plain sailing.

## Day 6

### Part 1

This was a fun one, and another time to break out the linked list. Part 1 went pretty smoothly, I did enjoy getting to name a class `Space::Object`, it reminded me of cheesy sci-fi stories, where they put "space-" in front of the normal words to make them sound more spacey.

### Part 2

Part 2 seemed like it should have been straight forward. I decided to implement a depth-first search, except it had been a long time since I did anything like that, and it took me quite a few iterations to actually get the search working.

## Day 7

### Part 1

One week in, and still going strong. One again the intcode computer was required, and this time I was able to subclass the one from day 5. I was surprised when the description mentioned pausing the program while waiting for input, as it seemed to me I could run each amplifier to completion, before starting the next one, with it's input pre-populated with the output from the previous amplifier. So that's what I did, and it worked! Of course I should have known, waiting for input wouldn't have been mentioned if it wasn't at least _going_ to be needed.

A special mention needs to go to Ruby's `Array.permutation` method, which basically felt like a bit of a win button on this one. Having a method that automatically returns every possible combination of an array's elements basically did half the work for me.

### Part 2

Part 2 introduced a positive feedback loop, which is when I discovered my computer would need to be able to pause and wait for the next input, as amp 1 needs to be able to receive an input from amp 5, and in my previous model, amp 5 wouldn't start until amp 1 had already finished.

Other than having to modify my amp to be able to wait for the next input, part 2 didn't require much change from part 1, just a different set of phases, and linking amp 5's output to amp 1's input.

