# frozen_string_literal: true

require 'text_handler/text_block'

describe TextHandler::TextBlock do
  let(:lines) { subject.lines }

  context 'when receiving a text block index/name' do
    subject { described_class.new('introduction') }
    let(:line) { 'You are waken up by a strange guy.' }
    let(:second_line) { 'Hello, I\'m %<stranger>' }
    let(:formatted_second_line) { 'Hello, I\'m Sauron' }

    it 'contains the block lines' do
      expect(lines.count).to eq(2)
      expect(lines.first).to include(line)
      expect(lines.last).to include(second_line)
    end

    context 'and calling the #print_content method' do
      it 'prints the text to the screen' do
        expect do
          subject.print_content
        end.to output(a_string_including(line, second_line)).to_stdout
      end

      context 'informing vars to be replaced' do
        subject do
          described_class.new('introduction', stranger: 'Sauron')
        end

        it 'prints text with replaced content' do
          expect do
            subject.print_content
          end.to output(a_string_including(formatted_second_line)).to_stdout
        end
      end
    end
  end

  context 'when receiving a text block name that does not exist' do
    subject { described_class.new('random_block') }

    it 'returns an empty list' do
      expect(lines).to be_empty
    end
  end
end
