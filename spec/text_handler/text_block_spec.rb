# frozen_string_literal: true

require 'text_handler/text_block'

describe TextHandler::TextBlock do
  let(:lines) { subject.lines }

  context 'when receiving a text block index/name' do
    subject { described_class.new('introduction') }

    it 'contains the block lines' do
      expect(lines.count).to eq(2)
      expect(lines.first).to include('You are waken up by a strange guy.')
      expect(lines.last).to include('Hello, I\'m %{stranger}')
    end
  end

  context 'when receiving a text block name that does not exist' do
    subject { described_class.new('random_block') }

    it 'returns an empty list' do
      expect(lines).to be_empty
    end
  end
end
