load "computer.rb"

class JumpingComputer < Computer
  OP_MAP = {
    1 => :add,
    2 => :multiply,
    3 => :write_to,
    4 => :read_from,
    5 => :jump_if_true,
    6 => :jump_if_false,
    7 => :less_than,
    8 => :equals,
    99 => :exit
  }

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
end