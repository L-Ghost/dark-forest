# frozen_string_literal: true

require 'text_handler/replacer'

describe TextHandler::Replacer do
  subject { described_class.new(line, vars) }

  context 'when receiving a text line code' do
    context 'without any var' do
      let(:line) do
        'You are waken up by a strange guy. You notice you are below a tree' \
        ', inside a dark forest.'
      end
      let(:vars) { nil }

      it 'retrieves the same text' do
        expect(subject.call).to eq(line)
      end
    end

    context 'with a variable to be replaced among the text' do
      let(:vars) { { stranger: 'Melvin' } }
      let(:line) do
        '"Hello, I\'m %<stranger>. What is your name?" - asks the guy.'
      end
      let(:replaced_line) do
        '"Hello, I\'m Melvin. What is your name?" - asks the guy.'
      end
      it 'retrieves the correct text with the variable replaced' do
        expect(subject.call).to eq(replaced_line)
      end
    end

    context 'with more than one variable to be replaced among the text' do
      let(:vars) { { stranger: 'Scar', hero: 'Simba' } }
      let(:line) do
        '"So, you\'re a brave one, %<hero>..." - says %<stranger>' \
        ', portraying an ironic smile.'
      end
      let(:replaced_line) do
        '"So, you\'re a brave one, Simba..." - says Scar' \
        ', portraying an ironic smile.'
      end
      it 'retrieves the correct text with the variables replaced' do
        expect(subject.call).to eq(replaced_line)
      end
    end
  end
end
