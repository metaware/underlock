$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "underlock"
require "pry"


RSpec.configure do |config|
  Underlock::Base.configure do |config|
    config.public_key  = File.read('./spec/key.pub')
    config.private_key = File.read('./spec/key.priv')
    config.cipher      = OpenSSL::Cipher.new('aes-256-gcm')
  end
end