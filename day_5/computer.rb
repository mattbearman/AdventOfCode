class Computer
  OP_MAP = {
    1 => :add,
    2 => :multiply,
    3 => :write_to,
    4 => :read_from,
    99 => :exit
  }

  PARAM_MODES = {
    0 => :pointer,
    1 => :value
  }

  attr_accessor :memory, :pointer, :param_modes, :input, :output

  def initialize(memory)
    @memory = memory
    parse_memory
    @pointer = 0
  end

  def parse_memory
    return if memory.kind_of? Array

    self.memory = memory.split(",").map(&:to_i)
  end

  def execute
    while do_op; end
  end

  def do_op
    op_code, param_modes = split_code_and_modes

    self.set_param_modes(param_modes)

    op = op_method(op_code)

    return if op.nil? || op == :exit

    send(op)
  end

  def split_code_and_modes
    code_and_modes = read_memory!

    op_code = code_and_modes % 100
    modes = (code_and_modes - op_code) / 100

    return op_code, modes
  end

  def set_param_modes(modes)
    self.param_modes = modes.digits
  end

  def op_method(op_code)
    OP_MAP[op_code]
  end

  def add
    put_result!(params(2).sum)
  end

  def multiply
    put_result!(params(2).reduce(&:*))
  end

  def write_to
    memory[read_memory!] = input
  end

  def read_from
    self.output = memory[read_memory!]
  end

  def read_memory
    memory[pointer]
  end

  def read_memory!
    value = read_memory
    
    advance_pointer

    value
  end

  def advance_pointer
    self.pointer += 1
  end

  def params(length)
    length.times.each_with_index.map do | _, index |
      send(param_method(index))
    end
  end

  def param_method(param_index)
    "param_by_#{PARAM_MODES[param_mode_for(param_index)]}".to_sym
  end

  def param_by_pointer
    memory[read_memory!]
  end

  def param_by_value
    read_memory!
  end

  def param_mode_for(param_index)
    # default to pointer mode if mode is not defined
    param_modes[param_index] || 0
  end

  def put_result!(result)
    memory[result_pointer] = result
    
    advance_pointer
  end

  def result_pointer
    memory[pointer]
  end
end

c = Computer.new("1,1,1,4,99,5,6,0,99")
c.execute

raise "day 2 failed" if c.memory != [30,1,1,4,2,5,6,0,99]

c = Computer.new("3,0,4,0,99")
c.input = "hi"
c.execute

raise "day 5 failed" if c.memory != ["hi", 0, 4, 0, 99]

c = Computer.new("1002,4,3,4,33")
c.execute

raise "day 5.2 failed" if c.memory != [1002,4,3,4,99]
