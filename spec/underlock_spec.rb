require "spec_helper"

describe Underlock do
  it "has a version number" do
    expect(Underlock::VERSION).not_to be nil
  end

  context 'configurable' do

    before do
      Underlock::Base.configure do |config|
        config.public_key = 'public'
        config.private_key = 'private'
      end
    end

    it 'is expected to have a public_key' do
      expect(Underlock::Base.config.public_key).to eq('public')
    end

    it 'is expected to have a private' do
      expect(Underlock::Base.config.private_key).to eq('private')
    end
  end

  # Underlock.encrypt('string')
  # Underlock.encrypt(File.new)
  # Underlock.decrypt('encrypted-string')
  # Underlock.decrypt(File.new)
end
