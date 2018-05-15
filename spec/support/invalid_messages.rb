RSpec.shared_examples 'invalid messages' do |*messages|
  it "should return false" do
    messages.each do |message|
      expect(described_class.new message).not_to be_valid
    end
  end
end
