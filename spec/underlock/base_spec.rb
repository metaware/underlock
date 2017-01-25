require 'spec_helper'

describe Underlock::Base do

  it 'should implement #encrypt & #decrypt' do
    expect(described_class).to respond_to(:encrypt)
    expect(described_class).to respond_to(:decrypt)
  end

  context 'string encryption' do
    let(:secret)  { Underlock::Base.encrypt(message) }

    context 'encrypt' do

      let(:message) { 'secret message: unicorns' }

      it 'should return an instance of EncryptedEntity' do
        expect(secret).to be_an_instance_of(Underlock::EncryptedEntity)
      end

      it 'should not have the original value' do
        expect(secret.value).to_not eq(message)
      end

      it 'should be able to decrypt the gibberish back to the actual message' do
        expect(Underlock::Base.decrypt(secret)).to eq(message)
      end

    end

    context 'decrypt' do

      let(:message) { 'super secret message to get across' }

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

        it 'should be able to decrypt the gibberish back to the actual message' do
          expect(Underlock::Base.decrypt(secret)).to eq(message)
        end

      end
    end
  end

  context 'file encryption' do
    let(:secret)  { Underlock::Base.encrypt(file) }

    %w(file.pdf file.txt).each do |filename|
      let(:file)    { File.open("./spec/files/#{filename}") }

      context 'encrypt' do
        
        it 'should return an instance of EncryptedEntity' do
          expect(secret).to be_an_instance_of(Underlock::EncryptedEntity)
        end

        it 'should respond to #encrypted_file' do
          expect(secret).to respond_to(:encrypted_file)
        end

        it 'should not have the original value' do
          expect(File.read(secret.encrypted_file)).to_not eq(File.read(file))
        end
      end

      context 'decrypt' do
        let(:encrypted_entity) { Underlock::Base.encrypt(file) }

        it 'should be able to return a file for an encrypted file' do
          expect(Underlock::Base.decrypt(encrypted_entity)).to be_an_instance_of(File)
        end

        it 'should be able to read the contents of the file' do
          decrypted_file = Underlock::Base.decrypt(encrypted_entity)
          yomu = Yomu.new(decrypted_file.to_path)
          expect(yomu.text.strip).to eq("super secret message in the pdf file")
        end
      end
    end

  end
end