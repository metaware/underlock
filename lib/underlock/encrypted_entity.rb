module Underlock
  class EncryptedEntity

    attr_accessor :value, :key, :iv
    def initialize(value, key:, iv:)
      @value = value
      @key = key
      @iv = iv
    end

    def decrypt
      Encryptor.decrypt(self)
    end

    def inspect
      self.to_s
    end

  end
end