module Underlock
  class Encryptor

    def encrypt(value)
      cipher = Underlock::Base.config.cipher.dup
      cipher.encrypt
      key = cipher.random_key
      iv  = cipher.random_iv

      encrypted_value = base64_encode(cipher.update(value))
      encrypted_key = public_encrypt(key)
      encrypted_iv  = public_encrypt(iv)

      EncryptedEntity.new(value: encrypted_value, key: encrypted_key, iv: encrypted_iv)
    end

    def decrypt(encrypted_entity)
      decode_cipher = Underlock::Base.config.cipher.dup
      decode_cipher.decrypt
      decode_cipher.key = private_decrypt(encrypted_entity.key)
      decode_cipher.iv = private_decrypt(encrypted_entity.iv)
      decode_cipher.update(base64_decode(encrypted_entity.value)[0])
    end

    private

    def public_encrypt(value)
      key = OpenSSL::PKey::RSA.new(Underlock::Base.config.public_key)
      base64_encode(key.public_encrypt(base64_encode(value)))
    end

    def private_decrypt(value)
      key = OpenSSL::PKey::RSA.new(Underlock::Base.config.private_key)
      base64_decode(key.private_decrypt(base64_decode(value)[0]))[0]
    end

    def base64_encode(value)
      [value].pack('m')
    end

    def base64_decode(value)
      value.unpack('m')
    end

  end
end