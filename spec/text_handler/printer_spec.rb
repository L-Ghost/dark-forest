# frozen_string_literal: true

require 'text_handler/printer'

describe TextHandler::Printer do
  context 'when receiving a line of text' do
    let(:line) { '"Hello, I\'m Bowser. What is your name?\" - asks the guy.' }
    subject { described_class.new(line) }
    it 'prints the text to the screen' do
      expect do
        subject.call
      end.to output(a_string_including(line)).to_stdout
    end
  end
end
