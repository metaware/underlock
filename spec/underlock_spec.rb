require "spec_helper"

describe Underlock do
  it "has a version number" do
    expect(Underlock::VERSION).not_to be nil
  end

  # Underlock.configure do |config|
  #   config.public_key = ''
  #   config.private_key = ''
  # end

  # Underlock.encrypt('string')
  # Underlock.encrypt(File.new)
  # Underlock.decrypt('encrypted-string')
  # Underlock.decrypt(File.new)
end
