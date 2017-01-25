require 'spec_helper'

describe Underlock::Base do

  it 'should implement #encrypt & #decrypt' do
    expect(described_class).to respond_to(:encrypt)
    expect(described_class).to respond_to(:decrypt)
  end

  context 'encrypt' do

    let(:message) { 'secret message: unicorns' }
    let(:secret)  { Underlock::Base.encrypt(message) }

    it 'should return an instance of EncryptedEntity' do
      expect(secret).to be_an_instance_of(Underlock::EncryptedEntity)
    end

    it 'should have an unreadable value' do
      expect(secret.value).to_not eq(message)
    end

    it 'should be able to decrypt the gibberish back to the actual message' do
      expect(Underlock::Base.decrypt(secret)).to eq(message)
    end

  end

  context 'decrypt' do

    let(:message) { 'super secret message to get across' }
    let(:secret)  { Underlock::Base.encrypt(message) }

    it 'should be able to decrypt the gibberish back to the actual message' do
      expect(Underlock::Base.decrypt(secret)).to eq(message)
    end

    context 'multiline strings' do
      let(:message) do
        message = <<-SECRET_MESSAGE
          This here is a 
          multiline string,
          and also a super secret message
          that should be protected
        SECRET_MESSAGE
      end
      let(:secret)  { Underlock::Base.encrypt(message) }

      it 'should be able to decrypt the gibberish back to the actual message' do
        expect(Underlock::Base.decrypt(secret)).to eq(message)
      end

    end
  end
end