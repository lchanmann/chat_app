RSpec.shared_examples 'accepting visitor' do |method_name|
  let(:visitor) { double('visitor') }

  subject { described_class.new 'message' }

  it "should delegate #{method_name} to visitor" do
    expect(visitor).to receive(method_name)
    subject.accept visitor
  end
end
