# frozen_string_literal: true

require 'yaml'

module TextHandler
  class TextBlock
    TEXT_BLOCK = 'text_block'

    attr_reader :block_name, :yml

    def initialize(block_name)
      @block_name = block_name
      @yml = YAML.safe_load(story_file)
    end

    def lines
      access_block
    end

    private

    def access_block
      block = yml.dig(TEXT_BLOCK, block_name)
      block.nil? ? [] : block.values
    end

    def story_file
      File.read('config/story.yml')
    end
  end
end