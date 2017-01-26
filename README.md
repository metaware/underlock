# Underlock

Underlock makes it dead simple to encrypt and decrypt your data and files. It comes with little to no dependencies and has a very small API surface.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'underlock'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install underlock

## Initialization

```ruby
Underlock::Base.configure do |config|
  config.public_key  = File.read('./key.pub')
  config.private_key = File.read('./key.priv')
  config.cipher      = OpenSSL::Cipher.new('aes-256-gcm')
end
```

For the `config.cipher` value, all algorithms available in `OpenSSL::Cipher.ciphers` are supported.

## Generating Public/Private keypair

```ruby
key = OpenSSL::PKey::RSA.new 4096
puts key.to_pem
puts key.public_key.to_pem
```

## Usage

### Encrypting Strings/Text

```ruby
irb> Underlock::Base.encrypt("super secret message")
=> #<Underlock::EncryptedEntity:0x007fef2e4b8320>
```

`Underlock::EncryptedEntity` has the following 3 methods

```ruby
encrypted_entity.value
encrypted_entity.key
encrypted_entity.iv # iv stands for initialization vector
```

You should persist or store the `key` and `iv` in order to be able to decrypt the encrypted `value`.

### Decrypting Strings/Text

- Create an instance of `Underlock::EncryptedEntity`, use the `key` and `iv` collected in the previous steps.

```ruby
irb> encrypted_entity = Underlock::EncryptedEntity.new(value: value, key: key, iv: iv)
```

- Decrypt using one of the following methods:

```ruby
irb> encrypted_entity.decrypt
```

```ruby
irb> Underlock::Base.decrypt(encrypted_entity)
```

### Encrypting Files

To encrypt files, instead of passing a `String` object, pass a `File` object to `Underlock::Base.encrypt`

```ruby
irb> file = File.open('/path/to/your/secret/file.txt')
irb> Underlock::Base.encrypt(file)
=> #<Underlock::EncryptedEntity:0x007fef2e4b8320>
```

The return value is an instance of `Underlock::EncryptedEntity` and has the following methods:

```ruby
encrypted_entity.encrypted_file
encrypted_entity.key
encrypted_entity.iv # iv stands for initialization vector here
```

`#encrypted_file` returns a `File` object. This file is saved in the same directory as your original file.

### Decrypting Files

- Create an instance of `Underlock::EncryptedEntity`, use the `key` and `iv` collected in the previous steps.

```ruby
irb> file = File.open('/path/to/your/secret/file.txt.enc')
irb> encrypted_entity = Underlock::EncryptedEntity.new(encrypted_file: file, key: key, iv: iv)
```

- Decrypt using one of the following methods:

```ruby
irb> encrypted_entity.decrypt
```

```ruby
irb> Underlock::Base.decrypt(encrypted_entity)
```

Following naming scheme is followed when encrypting/decrypting files:

| original file name | encrypted file name | decrypted file name |
|--------------------|---------------------|---------------------|
| file.pdf           | file.pdf.enc        | file.decrypted.pdf  |

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/metaware/underlock.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

