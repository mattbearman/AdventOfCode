def test(password)
  pass = false
  last_num = nil

  password.to_s.each_char do | num |
    num = num.to_i

    return false if last_num && num < last_num

    pass = true if num == last_num

    last_num = num
  end

  return pass
end

passwords = 0

(372304..847060).each do | password |
  passwords += 1 if test(password)
end

p passwords
