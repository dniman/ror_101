# frozen_string_literal: true

require_relative 'utils/string_utils'

module Utils
  refine String do
    import_methods StringUtils
  end
end
