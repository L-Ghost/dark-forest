# frozen_string_literal: true

module TextHandler
  # gets a line from yml file
  class Retriever
    attr_reader :line_reference, :vars, :yml, :line

    def initialize(line_reference, vars = nil)
      @line_reference = line_reference
      @vars = vars
    end

    def call
      @yml = YAML.safe_load(story_file)
      access_line
      return line unless vars

      replace_vars && line
    end

    def story_file
      File.read('config/story.yml')
    end

    def access_line
      @line = yml
      line_reference.split('.').each do |part|
        @line = line.dig(part)
      end
    end

    def replace_vars
      vars.keys.each do |key|
        @line = line.gsub("%{#{key}}", vars[key])
      end
    end
  end
end
