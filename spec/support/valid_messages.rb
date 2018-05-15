RSpec.shared_examples 'valid messages' do |*messages|
  it "should return true" do
    messages.each do |message|
      expect(described_class.new message).to be_valid
    end
  end
end
