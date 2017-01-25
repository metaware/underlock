module Underlock
  class Base
    extend Dry::Configurable

    setting :private_key
    setting :public_key
    setting :passphrase
    setting :cipher

    class << self

      def encrypt(string)
        Encryptor.encrypt(string)
      end

      def decrypt(encrypted_entity)
        encrypted_entity.decrypt
      end

    end
  end
end