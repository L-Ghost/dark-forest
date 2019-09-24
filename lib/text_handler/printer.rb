# frozen_string_literal: true

module TextHandler
  # prints a line of text to the screen
  class Printer
    attr_reader :line

    def initialize(line)
      @line = line
    end

    def call
      puts line
    end
  end
end
