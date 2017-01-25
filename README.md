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
encrypted_entity.iv
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

TODO: Documentation coming soon, please see `spec/` folder until then.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/metaware/underlock.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

