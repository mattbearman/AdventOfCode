load "../day_5/computer.rb" unless defined? Computer
load "../day_5/jumping_computer.rb" unless defined? JumpingComputer

class CompleteComputer < JumpingComputer
  MEMORY_SIZE = 1024 * 128

  attr_accessor :relative_base

  def initialize(memory)
    super(memory)

    pad_memory

    @relative_base = 0
    @output = []
  end

  def pad_memory
    memory[MEMORY_SIZE] ||= 0

    zero_extended_memory
  end

  def zero_extended_memory
    memory.map! { | e | e || 0 }
  end

  def op_map
    super.merge({
      9 => :relative_base_offset
    })
  end

  def read_from
    self.output << next_param
  end

  def relative_base_offset
    self.relative_base += next_param
  end

  def param_modes
    super.merge({
      2 => :relative
    })
  end

  def param_by_relative
    memory[relative_base + read_memory!]
  end

  def put_result!(result)
    case next_param_mode
    when 2
      memory[relative_base + read_memory!] = result
    else # 0 and 1 are treated as relative when writing
      memory[read_memory!] = result
    end
  end
end

c = CompleteComputer.new("109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99")
c.execute
raise "day 9.1 test 1 failed - output: #{c.output.join(",")} != 109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99" if c.output.join(",") != "109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99"

c = CompleteComputer.new("1102,34915192,34915192,7,4,7,99,0")
c.execute
out = c.output[0]
raise "day 9.1 test 2 failed - output: #{out} != 16 digit num" if out.digits.length != 16

c = CompleteComputer.new("104,1125899906842624,99")
c.execute
out = c.output[0]
raise "day 9.1 test 3 failed - output: #{out} != 1125899906842624" if out != 1125899906842624


