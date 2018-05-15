require 'bob_bot'

RSpec.describe BobBot do
  subject { described_class.default }

  describe '#message_types' do
    it do
      expect(subject.message_types).to eq([
        MessageTypes::Question,
        MessageTypes::Yell,
        MessageTypes::Empty,
        MessageTypes::Anything
      ])
    end
  end

  describe '.respond_to_question' do
    it { expect(subject.respond_to_question).to eq('Sure.') }
  end

  describe '.respond_to_yell' do
    it { expect(subject.respond_to_yell).to eq('Woah, chill out!') }
  end

  describe '.respond_to_empty' do
    it { expect(subject.respond_to_empty).to eq('Fine. Be that way!') }
  end

  describe '.respond_to_anything' do
    it { expect(subject.respond_to_anything).to eq('Whatever.') }
  end

  describe '#respond' do
    context 'when asking a question' do
      let(:text) { 'question?' }

      it "should respond to question" do
        is_expected.to receive(:respond_to_question)
        subject.respond(text)
      end
    end

    context 'when yelling' do
      let(:text) { 'YELL' }

      it "should respond to yell" do
        is_expected.to receive(:respond_to_yell)
        subject.respond(text)
      end
    end

    context 'when called but saying nothing' do
      let(:text) { '' }

      it "should respond to empty" do
        is_expected.to receive(:respond_to_empty)
        subject.respond(text)
      end
    end

    context 'when saying anything' do
      let(:text) { 'anything' }

      it "should respond to anything" do
        is_expected.to receive(:respond_to_anything)
        subject.respond(text)
      end
    end

    context 'when called with nil' do
      let(:text) { nil }

      it do
        expect {
          subject.respond text
        }.to raise_error(RuntimeError, "Can't respond to: nil")
      end
    end
  end
end
