load "../day_5/computer.rb" unless Computer
load "../day_5/jumping_computer.rb" unless JumpingComputer

class Amp < JumpingComputer
  STATUS_IDLE = 0
  STATUS_RUNNING = 1
  STATUS_WAITING = 2

  attr_accessor :status, :next_amp

  def initialize(memory:, input:[])
    super(memory)
    @input = input
    @status = STATUS_IDLE
  end

  def execute
    self.status = STATUS_RUNNING
    
    while do_op
      break if status == STATUS_WAITING
    end
  end

  def write_to
    if input.any?
      put_result!(input.shift)
    else
      self.status = STATUS_WAITING
    end
  end

  def read_from
    self.output = next_param

    if next_amp
      next_amp.add_to_input_buffer(output)
    end
  end

  def add_to_input_buffer(input)
    self.input << input

    if status == STATUS_WAITING
      write_to
      execute
    end
  end
end

class AmpSet
  attr_accessor :amps
  attr_reader :program

  def initialize(program:)
    @program = program
  end

  def find_all_outputs
    phases.permutation.map do | phases |
      find_output_for_phases(phases)
    end
  end

  def phases
    [0,1,2,3,4]
  end

  def find_max_output
    find_all_outputs.max
  end

  def find_output_for_phases(phases)
    self.amps = phases.map { | phase | Amp.new(memory: program, input: [phase]) }

    amps.each_with_index do | amp, i |
      if next_amp = amp_after(i)
        amp.next_amp = next_amp
      end
    end

    amps[0].add_to_input_buffer(0);
    amps.map(&:execute)

    return amps.last.output
  end

  def amp_after(current_amp_id)
    amps[current_amp_id + 1]
  end
end

class PositiveFeedbackAmpSet < AmpSet
  def phases
    [5,6,7,8,9]
  end

  def amp_after(current_amp_id)
    amps[current_amp_id + 1] || amps[0]
  end
end

# "tests"

amp_set = AmpSet.new(program: "3,15,3,16,1002,16,10,16,1,16,15,15,4,15,99,0,0")
raise "day 7.1 test 1 failed - output: #{amp_set.find_max_output} != 43210" if amp_set.find_max_output != 43210

amp_set = AmpSet.new(program: "3,23,3,24,1002,24,10,24,1002,23,-1,23,101,5,23,23,1,24,23,23,4,23,99,0,0")
raise "day 7.1 test 2 failed - output: #{amp_set.find_max_output} != 54321" if amp_set.find_max_output != 54321

amp_set = AmpSet.new(program: "3,31,3,32,1002,32,10,32,1001,31,-2,31,1007,31,0,33,1002,33,7,33,1,33,31,31,1,32,31,31,4,31,99,0,0,0")
raise "day 7.1 test 3 failed - output: #{amp_set.find_max_output} != 65210" if amp_set.find_max_output != 65210

amp_set = PositiveFeedbackAmpSet.new(program: "3,26,1001,26,-4,26,3,27,1002,27,2,27,1,27,26,27,4,27,1001,28,-1,28,1005,28,6,99,0,0,5")
raise "day 7.2 test 1 failed - output: #{amp_set.find_max_output} != 139629729" if amp_set.find_max_output != 139629729

amp_set = PositiveFeedbackAmpSet.new(program: "3,52,1001,52,-5,52,3,53,1,52,56,54,1007,54,5,55,1005,55,26,1001,54,-5,54,1105,1,12,1,53,54,53,1008,54,0,55,1001,55,1,55,2,53,55,53,4,53,1001,56,-1,56,1005,56,6,99,0,0,0,0,10")
raise "day 7.2 test 1 failed - output: #{amp_set.find_max_output} != 18216" if amp_set.find_max_output != 18216

