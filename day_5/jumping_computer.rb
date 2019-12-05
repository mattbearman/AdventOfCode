load "computer.rb"

class JumpingComputer < Computer
  EXT_OP_MAP = {
    5 => :jump_if_true,
    6 => :jump_if_false,
    7 => :less_than,
    8 => :equals,
    99 => :exit
  }

  def op_method(op_code)
    OP_MAP.merge(EXT_OP_MAP)[op_code]
  end
  
  def jump_if_true
    check, jump_to = params(2)

    unless check == 0
      self.pointer = jump_to
    end
  end

  def jump_if_false
    check, jump_to = params(2)

    if check == 0
      self.pointer = jump_to
    end
  end

  def less_than
    p1, p2 = params(2)
    put_result!(p1 < p2 ? 1 : 0)
  end

  def equals
    p1, p2 = params(2)
    put_result!(p1 == p2 ? 1 : 0)
  end
end

# Tests

c = JumpingComputer.new("3,225,1,225,6,6,1100,1,238,225,104,0,1002,92,42,224,1001,224,-3444,224,4,224,102,8,223,223,101,4,224,224,1,224,223,223,1102,24,81,225,1101,89,36,224,101,-125,224,224,4,224,102,8,223,223,101,5,224,224,1,224,223,223,2,118,191,224,101,-880,224,224,4,224,1002,223,8,223,1001,224,7,224,1,224,223,223,1102,68,94,225,1101,85,91,225,1102,91,82,225,1102,85,77,224,101,-6545,224,224,4,224,1002,223,8,223,101,7,224,224,1,223,224,223,1101,84,20,225,102,41,36,224,101,-3321,224,224,4,224,1002,223,8,223,101,7,224,224,1,223,224,223,1,188,88,224,101,-183,224,224,4,224,1002,223,8,223,1001,224,7,224,1,224,223,223,1001,84,43,224,1001,224,-137,224,4,224,102,8,223,223,101,4,224,224,1,224,223,223,1102,71,92,225,1101,44,50,225,1102,29,47,225,101,7,195,224,101,-36,224,224,4,224,102,8,223,223,101,6,224,224,1,223,224,223,4,223,99,0,0,0,677,0,0,0,0,0,0,0,0,0,0,0,1105,0,99999,1105,227,247,1105,1,99999,1005,227,99999,1005,0,256,1105,1,99999,1106,227,99999,1106,0,265,1105,1,99999,1006,0,99999,1006,227,274,1105,1,99999,1105,1,280,1105,1,99999,1,225,225,225,1101,294,0,0,105,1,0,1105,1,99999,1106,0,300,1105,1,99999,1,225,225,225,1101,314,0,0,106,0,0,1105,1,99999,107,677,677,224,1002,223,2,223,1006,224,329,1001,223,1,223,1108,226,677,224,102,2,223,223,1006,224,344,101,1,223,223,1107,226,226,224,1002,223,2,223,1006,224,359,101,1,223,223,8,677,226,224,1002,223,2,223,1006,224,374,1001,223,1,223,1107,677,226,224,102,2,223,223,1005,224,389,1001,223,1,223,1008,677,677,224,1002,223,2,223,1006,224,404,1001,223,1,223,108,677,677,224,102,2,223,223,1005,224,419,1001,223,1,223,1107,226,677,224,102,2,223,223,1006,224,434,101,1,223,223,1008,226,226,224,1002,223,2,223,1006,224,449,1001,223,1,223,107,226,226,224,102,2,223,223,1006,224,464,1001,223,1,223,1007,677,226,224,1002,223,2,223,1006,224,479,1001,223,1,223,1108,226,226,224,102,2,223,223,1006,224,494,1001,223,1,223,8,226,226,224,1002,223,2,223,1005,224,509,1001,223,1,223,7,226,677,224,102,2,223,223,1005,224,524,101,1,223,223,1008,677,226,224,102,2,223,223,1005,224,539,101,1,223,223,107,226,677,224,1002,223,2,223,1006,224,554,1001,223,1,223,1108,677,226,224,102,2,223,223,1005,224,569,101,1,223,223,108,226,226,224,1002,223,2,223,1005,224,584,1001,223,1,223,7,677,226,224,1002,223,2,223,1005,224,599,1001,223,1,223,108,226,677,224,1002,223,2,223,1006,224,614,101,1,223,223,1007,677,677,224,1002,223,2,223,1006,224,629,101,1,223,223,7,677,677,224,102,2,223,223,1005,224,644,101,1,223,223,1007,226,226,224,1002,223,2,223,1006,224,659,1001,223,1,223,8,226,677,224,102,2,223,223,1005,224,674,1001,223,1,223,4,223,99,226")
c.input = 1
c.execute
raise "day 5.1 test failed - o:#{c.output}" if c.output != 9961446


c = JumpingComputer.new("3,9,8,9,10,9,4,9,99,-1,8")
c.input = 8
c.execute
raise "day 5.2 test 1.1 failed - o:#{c.output}, m:#{c.memory}" if c.output != 1

c = JumpingComputer.new("3,9,8,9,10,9,4,9,99,-1,8")
c.input = 7
c.execute
raise "day 5.2 test 1.2 failed - o:#{c.output}, m:#{c.memory}" if c.output != 0

c = JumpingComputer.new("3,9,8,9,10,9,4,9,99,-1,8")
c.input = 9
c.execute
raise "day 5.2 test 1.3 failed - o:#{c.output}, m:#{c.memory}" if c.output != 0


c = JumpingComputer.new("3,9,7,9,10,9,4,9,99,-1,8")
c.input = 7
c.execute
raise "day 5.2 test 2.1 failed - o:#{c.output}, m:#{c.memory}" if c.output != 1

c = JumpingComputer.new("3,9,7,9,10,9,4,9,99,-1,8")
c.input = 8
c.execute
raise "day 5.2 test 2.2 failed - o:#{c.output}, m:#{c.memory}" if c.output != 0

c = JumpingComputer.new("3,9,7,9,10,9,4,9,99,-1,8")
c.input = 9
c.execute
raise "day 5.2 test 2.3 failed - o:#{c.output}, m:#{c.memory}" if c.output != 0


c = JumpingComputer.new("3,3,1108,-1,8,3,4,3,99")
c.input = 8
c.execute
raise "day 5.2 test 3.1 failed - o:#{c.output}, m:#{c.memory}" if c.output != 1

c = JumpingComputer.new("3,3,1108,-1,8,3,4,3,99")
c.input = 6
c.execute
raise "day 5.2 test 3.2 failed - o:#{c.output}, m:#{c.memory}" if c.output != 0

c = JumpingComputer.new("3,3,1108,-1,8,3,4,3,99")
c.input = 34
c.execute
raise "day 5.2 test 3.3 failed - o:#{c.output}, m:#{c.memory}" if c.output != 0


c = JumpingComputer.new("3,3,1107,-1,8,3,4,3,99")
c.input = -9
c.execute
raise "day 5.2 test 4.1 failed - o:#{c.output}, m:#{c.memory}" if c.output != 1

c = JumpingComputer.new("3,3,1107,-1,8,3,4,3,99")
c.input = 8
c.execute
raise "day 5.2 test 4.2 failed - o:#{c.output}, m:#{c.memory}" if c.output != 0

c = JumpingComputer.new("3,3,1107,-1,8,3,4,3,99")
c.input = 9999
c.execute
raise "day 5.2 test 4.3 failed - o:#{c.output}, m:#{c.memory}" if c.output != 0


c = JumpingComputer.new("3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9")
c.input = 0
c.execute
raise "day 5.2 test 5.1 failed - o:#{c.output}, m:#{c.memory}" if c.output != 0

c = JumpingComputer.new("3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9")
c.input = 8
c.execute
raise "day 5.2 test 5.2 failed - o:#{c.output}, m:#{c.memory}" if c.output != 1


c = JumpingComputer.new("3,3,1105,-1,9,1101,0,0,12,4,12,99,1")
c.input = 0
c.execute
raise "day 5.2 test 6.1 failed - o:#{c.output}, m:#{c.memory}" if c.output != 0

c = JumpingComputer.new("3,3,1105,-1,9,1101,0,0,12,4,12,99,1")
c.input = -3
c.execute
raise "day 5.2 test 6.2 failed - o:#{c.output}, m:#{c.memory}" if c.output != 1


c = JumpingComputer.new("3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99")
c.input = 7
c.execute
raise "day 5.2 test 7.1 failed - o:#{c.output}, m:#{c.memory}" if c.output != 999

c = JumpingComputer.new("3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99")
c.input = 8
c.execute
raise "day 5.2 test 7.2 failed - o:#{c.output}, m:#{c.memory}" if c.output != 1000

c = JumpingComputer.new("3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99")
c.input = 9
c.execute
raise "day 5.2 test 7.3 failed - o:#{c.output}, m:#{c.memory}" if c.output != 1001
