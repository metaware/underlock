module Underlock
  class FileEncryptor

    def encrypt(file)
      file = File.realpath(file)
      @base_dir, @filename = File.split(file)
      cipher = Underlock::Base.config.cipher.dup
      cipher.encrypt
      key = cipher.random_key
      iv  = cipher.random_iv

      File.open(encrypted_filepath, "wb") do |encrypted_file|
        File.open(file, 'rb') do |inf|
          loop do
            r = inf.read(4096)
            break unless r
            encrypted_file << cipher.update(r)
          end
        end
        encrypted_file << cipher.final
      end

      encrypted_file = File.new(encrypted_filepath)
      encrypted_key  = public_encrypt(key)
      encrypted_iv   = public_encrypt(iv)

      EncryptedEntity.new(encrypted_file: encrypted_file, key: encrypted_key, iv: encrypted_iv)
    end

    def decrypt(encrypted_entity)
      decode_cipher = Underlock::Base.config.cipher.dup
      decode_cipher.decrypt
      decode_cipher.key = private_decrypt(encrypted_entity.key)
      decode_cipher.iv = private_decrypt(encrypted_entity.iv)

      @base_dir, @filename = File.split(encrypted_entity.encrypted_file)

      File.open(decrypted_filepath, 'wb') do |decrypted_file|
        File.open(encrypted_entity.encrypted_file, 'rb') do |inf|
          loop do
            r = inf.read(4096)
            break unless r
            decrypted_file << decode_cipher.update(r)
          end
        end
      end
      File.new(decrypted_filepath)
    end

    private

    def encrypted_filepath
      "#{@base_dir}/#{@filename}.enc"
    end

    def decrypted_filepath
      original_filename = @filename.gsub('.enc', '')
      extension = File.extname(original_filename)
      decrypted_filename = original_filename.gsub(extension, ".decrypted#{extension}")
      "#{@base_dir}/#{decrypted_filename}"
    end

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