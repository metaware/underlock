module Underlock
  class EncryptedEntity

    attr_accessor :value, :encrypted_file, :key, :iv
    def initialize(value: nil, encrypted_file: nil, key:, iv:)
      @encrypted_file = encrypted_file
      @value = value
      @key = key
      @iv = iv
    end

    def decrypt
      return Encryptor.new.decrypt(self) if value
      return FileEncryptor.new.decrypt(self) if encrypted_file
    end

    def inspect
      self.to_s
    end

  end
end