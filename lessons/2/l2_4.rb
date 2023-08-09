# frozen_string_literal: true

#
# Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1)
#

vowels = %w[а е и о у ы э ю я]
('а'..'я').each_with_index.each_with_object({}) do |(e, i), h|
  h[e] = i + 1 if vowels.detect { |v| v == e }
end
