class Computer
  OP_MAP = {
    1 => :add,
    2 => :multiply,
    99 => :exit
  }

  attr_accessor :memory, :pointer

  def initialize(memory)
    @memory = memory
    @pointer = 0
  end

  def execute
    while do_op
      next_op
    end
  end

  def op_code
    memory[pointer]
  end

  def do_op
    op = OP_MAP[op_code]

    return if op.nil? || op == :exit

    send(op)
  end

  def add
    put_result(params.sum)
  end

  def multiply
    put_result(params.reduce(&:*))
  end

  def params
    memory.values_at(*params_pointers)
  end

  def params_pointers
    memory[pointer+1, 2]
  end

  def put_result(result)
    memory[result_pointer] = result
  end

  def result_pointer
    memory[pointer+3]
  end

  def next_op
    self.pointer += 4
  end
end