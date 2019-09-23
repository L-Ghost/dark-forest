# frozen_string_literal: true

require 'text_handler/text_block_retriever'

describe TextHandler::TextBlockRetriever do
  context 'when receiving a block name' do
    let(:introduction_block) { 'introduction' }
    let(:first_line) do
      'You are waken up by a strange guy. You notice you are below a tree,' \
      ' inside a dark forest.'
    end
    let(:second_line) { 'What is your name?" - asks the guy.' }

    it 'returns an array containing the lines of text of this block' do
      block = described_class.new(introduction_block).call

      expect(block.count).to eq(2)
      expect(block[0]).to eq(first_line)
      expect(block[1]).to include(second_line)
    end
  end

  context 'when receiving a block name that is not defined' do
    it 'returns an empty array' do
      expect(described_class.new('banana').call).to be_empty
    end
  end
end
