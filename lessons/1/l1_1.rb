# frozen_string_literal: true

# Идеальный вес.
# Программа запрашивает у пользователя имя и рост и выводит идеальный вес по формуле (<рост> - 110) * 1.15,
# после чего выводит результат пользователю на экран с обращением по имени.
# Если идеальный вес получается отрицательным, то выводится строка "Ваш вес уже оптимальный"
#
printf 'Введите ваше Имя: '
name = gets.chomp!
printf 'Введите ваш рост(см): '
value = gets.chomp!

# Рост
height = Float(0)

begin
  height = Float(value)
rescue ArgumentError
  puts "Проверьте вводимое значение #{value}!"
  exit
end

weight = (height - 110) * 1.15

if weight.negative?
  puts 'Ваш вес уже оптимальный.'
else
  puts "#{name.capitalize}, ваш идеальный вес: #{format('%.1f', weight)} кг."
end
