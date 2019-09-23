# frozen_string_literal: true

require 'text_handler/retriever'

describe TextHandler::Retriever do
  context 'when receiving a text line code' do
    let(:line_reference) { 'text_block.introduction.line_1' }
    subject { described_class.new(line_reference) }
    let(:line) do
      'You are waken up by a strange guy. You notice you are below a tree' \
      ', inside a dark forest.'
    end

    it 'retrieves the correct text' do
      expect(subject.call).to eq(line)
    end

    context 'with a variable to be replaced among the text' do
      let(:line_reference) { 'text_block.introduction.line_2' }
      let(:vars) { { stranger: 'Melvin' } }
      subject { described_class.new(line_reference, vars) }
      let(:line) do
        '"Hello, I\'m Melvin. What is your name?" - asks the guy.'
      end
      it 'retrieves the correct text with the variable replaced' do
        expect(subject.call).to eq(line)
      end
    end

    context 'with more than one variable to be replaced among the text' do
      let(:line_reference) { 'text_block.sword_pick.line_2' }
      let(:vars) { { stranger: 'Scar', hero: 'Simba' } }
      subject { described_class.new(line_reference, vars) }
      let(:line) do
        '"So, you\'re a brave one, Simba..." - says Scar' \
        ', portraying an ironic smile.'
      end
      it 'retrieves the correct text with the variables replaced' do
        expect(subject.call).to eq(line)
      end
    end
  end
end
