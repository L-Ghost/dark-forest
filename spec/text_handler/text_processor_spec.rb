# frozen_string_literal: true

require 'text_handler/printer'
require 'text_handler/replacer'
require 'text_handler/text_processor'

describe TextHandler::TextProcessor do
  context 'when receiving an array of lines of text' do
    context 'without vars to be replaced' do
      let(:texts) { ['hello', 'may I help you?'] }
      subject { described_class.new(texts) }

      it 'calls the printer to prints the texts' do
        expect(TextHandler::Printer).to receive(:new)
          .with(texts.first).and_call_original
        expect(TextHandler::Printer).to receive(:new)
          .with(texts.last).and_call_original

        subject.call
      end
    end

    context 'with vars to be replaced' do
      let(:texts) { ['hello %<mr>', 'I am %<guy> and I will help you'] }
      let(:vars) { { mr: 'Luke', guy: 'Yoda' } }
      subject { described_class.new(texts, vars) }

      it 'calls both the printer and the replacer' do
        expect(TextHandler::Printer).to receive(:new)
          .with('hello Luke').and_call_original
        expect(TextHandler::Printer).to receive(:new)
          .with('I am Yoda and I will help you').and_call_original
        expect(TextHandler::Replacer).to receive(:new)
          .with(texts.first, vars).and_call_original
        expect(TextHandler::Replacer).to receive(:new)
          .with(texts.last, vars).and_call_original

        subject.call
      end
    end
  end
end
