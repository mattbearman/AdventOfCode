def test(password)
  pass = false
  last_num = nil

  counts = {
    1 => 0,
    2 => 0,
    3 => 0,
    4 => 0,
    5 => 0,
    6 => 0,
    7 => 0,
    8 => 0,
    9 => 0,
    0 => 0,
  }

  password.to_s.each_char do | num |
    num = num.to_i

    return false if last_num && num < last_num

    pass = true if num == last_num

    last_num = num

    counts[num] += 1
  end

  return pass if counts.any? { | _, value | value == 2 }

  return false
end

passwords = 0

(372304..847060).each do | password |
  passwords += 1 if test(password)
end

p passwords
