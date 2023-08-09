# frozen_string_literal: true

#
# Заданы три числа, которые обозначают число, месяц, год (запрашиваем у пользователя).
# Найти порядковый номер даты, начиная отсчет с начала года.
# Учесть, что год может быть високосным.
# (Запрещено использовать встроенные в ruby методы для этого вроде Date#yday или Date#leap?)
# Алгоритм опредления високосного года: docs.microsoft.com
#

printf "Программа выводит порядковый номер даты с начала года\n"

printf 'Введите число: '
day = gets.chomp.to_i

printf 'Введите месяц: '
month = gets.chomp.to_i

printf 'Введите год: '
year = gets.chomp.to_i

# Алогоритм определения високосного года
leap = (year % 4).zero? && !(year % 100).zero? || (year % 400).zero? ? true : false

# Заменим количество дней введеным числом
days = [
  month == 1 ? day : 31,
  if month == 2
    day
  else
    leap ? 29 : 28
  end,
  month == 3 ? day : 31,
  month == 4 ? day : 30,
  month == 5 ? day : 31,
  month == 6 ? day : 30,
  month == 7 ? day : 31,
  month == 8 ? day : 31,
  month == 9 ? day : 30,
  month == 10 ? day : 31,
  month == 11 ? day : 30,
  month == 12 ? day : 31
]

# Сформируем результирующий массив исключив ненужные месяцы
result = days.each_with_index.each_with_object([]) do |(e, i), a|
  a << e if (i + 1) <= month
end

printf "Порядковый номер даты #{day}.#{month}.#{year} с начала года: #{result.sum}\n"
