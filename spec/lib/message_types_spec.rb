require 'message_types'
require 'support/valid_messages'
require 'support/invalid_messages'
require 'support/accepting_visitor'

RSpec.describe MessageTypes::Question do
  it_behaves_like 'valid messages', 'question?', '?'
  it_behaves_like 'invalid messages', 'YELL', '', '123', 'anything', nil
  it_behaves_like 'accepting visitor', :respond_to_question
end

RSpec.describe MessageTypes::Yell do
  it_behaves_like 'valid messages', 'YELL'
  it_behaves_like 'invalid messages', 'question?', '', '123', 'anything', nil
  it_behaves_like 'accepting visitor', :respond_to_yell
end

RSpec.describe MessageTypes::Empty do
  it_behaves_like 'valid messages', ''
  it_behaves_like 'invalid messages', 'question?', 'YELL', '123', 'anything', nil
  it_behaves_like 'accepting visitor', :respond_to_empty
end

RSpec.describe MessageTypes::Anything do
  it_behaves_like 'valid messages', 'question?', 'YELL', '', '123', 'anything'
  it_behaves_like 'invalid messages', nil
  it_behaves_like 'accepting visitor', :respond_to_anything
end

RSpec.describe MessageTypes::Base do
  it_behaves_like 'valid messages', 'question?', 'YELL', '', '123', 'anything'
  it_behaves_like 'invalid messages', nil

  context 'when accepting visitor' do
    subject { MessageTypes::Base.new('message') }

    let(:visitor) { double('visitor') }

    it do
      expect {
        subject.accept(visitor)
      }.to raise_error(RuntimeError, "Not yet implemented")
    end
  end
end
