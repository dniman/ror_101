# frozen_string_literal: true

require_relative 'app'
require_relative 'subroutine_01'
require_relative 'subroutine_01_01'
require_relative 'subroutine_01_02'
require_relative 'subroutine_02'
require_relative 'subroutine_02_01'
require_relative 'subroutine_02_02'
require_relative 'subroutine_03'
require_relative 'subroutine_03_01'
require_relative 'subroutine_03_02'
require_relative 'subroutine_03_03'
require_relative 'subroutine_03_04'
require_relative 'subroutine_04'
require_relative 'subroutine_05'
require_relative 'subroutine_06'
require_relative 'subroutine_07'
require_relative 'subroutine_08'
require_relative 'subroutine_08_01'
require_relative 'subroutine_08_02'

app = App.new

subroutine_01 = Subroutine01.new
subroutine_01.register(Subroutine0101.new)
subroutine_01.register(Subroutine0102.new)

app.register(subroutine_01)

subroutine_02 = Subroutine02.new
subroutine_02.register(Subroutine0201.new)
subroutine_02.register(Subroutine0202.new)

app.register(subroutine_02)

subroutine_03 = Subroutine03.new
subroutine_03.register(Subroutine0301.new)
subroutine_03.register(Subroutine0302.new)
subroutine_03.register(Subroutine0303.new)
subroutine_03.register(Subroutine0304.new)
app.register(subroutine_03)

subroutine_04 = Subroutine04.new
app.register(subroutine_04)

subroutine_05 = Subroutine05.new
app.register(subroutine_05)

subroutine_06 = Subroutine06.new
app.register(subroutine_06)

subroutine_07 = Subroutine07.new
app.register(subroutine_07)

subroutine_08 = Subroutine08.new
subroutine_08.register(Subroutine0801.new)
subroutine_08.register(Subroutine0802.new)
app.register(subroutine_08)

app.run
