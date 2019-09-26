# frozen_string_literal: true

module TextHandler
  # formats a line with the vars received
  class Replacer
    attr_reader :line, :vars

    def initialize(line, vars = nil)
      @line = line
      @vars = vars
    end

    def call
      return line unless vars

      replace_vars && line
    end

    private

    def replace_vars
      vars.keys.each do |key|
        @line = line.gsub("%<#{key}>", vars[key])
      end
    end
  end
end
