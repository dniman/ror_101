# frozen_string_literal: true

# Квадратное уравнение.
# Пользователь вводит 3 коэффициента a, b и с.
# Программа вычисляет дискриминант (D) и корни уравнения (x1 и x2, если они есть)
# и выводит значения дискриминанта и корней на экран.
# При этом возможны следующие варианты:
#  Если D > 0, то выводим дискриминант и 2 корня
#  Если D = 0, то выводим дискриминант и 1 корень (т.к. корни в этом случае равны)
#  Если D < 0, то выводим дискриминант и сообщение "Корней нет"
# Подсказка: Алгоритм решения с блок-схемой (www.bolshoyvopros.ru).

# Коэффициенты квадратного уравнения
a = Integer(0)
b = Integer(0)
c = Integer(0)

puts 'Программа вычисляет дискриминант (D) и корни уравнения (x1 и x2, если они есть)'

printf 'Введите 1-ый коэффициент: '
value = gets.chomp!

begin
  a = Integer(value)
rescue ArgumentError
  puts "Проверьте 1-ый коэффициент #{value}!"
  exit
end

printf 'Введите 2-ой коэффициент: '
value = gets.chomp!

begin
  b = Integer(value)
rescue ArgumentError
  puts "Проверьте 2-ой коэффициент #{value}!"
  exit
end

printf 'Введите 3-ий коэффициент: '
value = gets.chomp!

begin
  c = Integer(value)
rescue ArgumentError
  puts "Проверьте 3-ий коэффициент #{value}!"
  exit
end

# D
d = b**2 - (4 * a * c)

if d.zero?
  x = (-1.0 * b) / (2 * a)
  puts "D = #{d}, x1 = x2 = #{x}"
elsif d.positive?
  x1 = (-1.0 * b + Math.sqrt(d)) / 2 * a
  x2 = (-1.0 * b - Math.sqrt(d)) / 2 * a
  puts "D = #{d}, x1 = #{x1}, x2 = #{x2}"
else
  puts "D = #{d}, Корней нет"
end
