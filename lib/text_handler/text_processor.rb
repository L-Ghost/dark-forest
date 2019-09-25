# frozen_string_literal: true

require_relative './printer'
require_relative './replacer'

module TextHandler
  # receives text to be processed and printed
  class TextProcessor
    attr_reader :text_block, :vars

    def initialize(text_block, vars = nil)
      @text_block = text_block
      @vars = vars
    end

    def call
      print_texts
    end

    private

    def print_texts
      @text_block.each do |line|
        line = replace_line(line) if vars
        print_line(line)
      end
    end

    def replace_line(line)
      TextHandler::Replacer.new(line, vars).call
    end

    def print_line(line)
      TextHandler::Printer.new(line).call
    end
  end
end
