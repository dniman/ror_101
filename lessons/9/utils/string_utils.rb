# frozen_string_literal: true

module Utils
  module StringUtils
    def underscore
      str = dup
      str.gsub!(/::/, '/')
      str.gsub!(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
      str.gsub!(/([a-z\d])([A-Z])/, '\1_\2')
      str.tr!('-', '_')
      str.downcase!
      str
    end

    def classify
      str = dup
      str = str.split('_')
      str.map(&:capitalize).join
    end
  end
end
