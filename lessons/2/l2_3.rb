# frozen_string_literal: true

#
# Заполнить массив числами фибоначчи до 100
#
# 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233,

fib = 0
arr = [0, 1]
loop do
  fib = arr[-1] + arr[-2]
  break if fib > 100

  arr << fib
end
