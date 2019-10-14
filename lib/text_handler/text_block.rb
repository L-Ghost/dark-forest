# frozen_string_literal: true

require 'yaml'

module TextHandler
  # handles a block of texts from a section of the game
  class TextBlock
    TEXT_BLOCK = 'text_block'

    attr_reader :block_name, :yml, :vars

    def initialize(block_name, vars = nil)
      @block_name = block_name
      @yml = YAML.safe_load(story_file)
      @vars = vars
    end

    def lines
      access_block
    end

    def print_content
      lines.each do |line|
        line = replace_vars(line) if vars
        puts line
      end
    end

    private

    def access_block
      block = yml.dig(TEXT_BLOCK, block_name)
      block.nil? ? [] : block.values
    end

    def replace_vars(line)
      vars.keys.each do |key|
        line = line.gsub("%<#{key}>", vars[key])
      end
      line
    end

    def story_file
      File.read('config/story.yml')
    end
  end
end
