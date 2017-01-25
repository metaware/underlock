module Underlock
  class Encryptor

    def self.encrypt(value)
      cipher = Underlock::Base.config.cipher.dup
      cipher.encrypt
      key = cipher.random_key
      iv  = cipher.random_iv

      encrypted_value = base64_encode(cipher.update(value))
      encrypted_key = public_encrypt(key)
      encrypted_iv  = public_encrypt(iv)

      EncryptedEntity.new(encrypted_value, key: encrypted_key, iv: encrypted_iv)
    end

    def self.decrypt(encrypted_entity)
      decode_cipher = Underlock::Base.config.cipher.dup
      decode_cipher.decrypt
      decode_cipher.key = private_decrypt(encrypted_entity.key)
      decode_cipher.iv = private_decrypt(encrypted_entity.iv)
      decode_cipher.update(base64_decode(encrypted_entity.value)[0])
    end

    private

    def self.public_encrypt(value)
      key = OpenSSL::PKey::RSA.new(Underlock::Base.config.public_key)
      base64_encode(key.public_encrypt(base64_encode(value)))
    end

    def self.private_decrypt(value)
      key = OpenSSL::PKey::RSA.new(Underlock::Base.config.private_key)
      base64_decode(key.private_decrypt(base64_decode(value)[0]))[0]
    end

    def self.base64_encode(value)
      [value].pack('m')
    end

    def self.base64_decode(value)
      value.unpack('m')
    end

  end
end