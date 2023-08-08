# frozen_string_literal: true

# Площадь треугольника.
# Площадь треугольника можно вычислить, зная его основание (a) и высоту (h) по формуле: 1/2*a*h. 
# Программа должна запрашивать основание и высоту треугольника и возвращать его площадь.

a = Float(0)      # Основание
h = Float(0)      # Высота
area = Float(0)   # Площадь

puts "Программа вычисляет площадь треугольника по основанию и высоте"
printf 'Введите основание треугольника: '
value = gets.chomp!

begin
   a = Float(value)
rescue ArgumentError
  puts "Проверьте основание треугольника #{value}!"
  exit
end

printf 'Введите высоту треугольника: '
value = gets.chomp!

begin
   h = Float(value)
rescue ArgumentError
  puts "Проверьте высоту треугольника #{value}!"
  exit
end

if a.negative? || h.negative?
  puts "Основание или высота не могут быть меньше 0!"
  exit
end

area = 1.0/2 * a * h

puts "Площадь треугольника: #{format('%.1f',area)}"
