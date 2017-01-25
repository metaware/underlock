 # Underlock

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/underlock`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

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

#### Encrypting Strings/Text

```
irb> Underlock::Base.encrypt("super secret message")
=> #<Underlock::EncryptedEntity:0x007fef2e4b8320>
```

`Underlock::EncryptedEntity` has the following 3 methods
```
encrypted_entity.value
encrypted_entity.key
encrypted_entity.iv
```

You should persist or store the `key` and `iv` in order to be able to decrypt the encrypted `value`.

#### Decrypting Strings/Text

1. Create an instance of `Underlock::EncryptedEntity`, use the `key` and `iv` collected in the previous steps.

```
irb> encrypted_entity = Underlock::EncryptedEntity.new(value: value, key: key, iv: iv)
```

2. Decrypt as follows:

```
irb> encrypted_entity.decrypt
irb> Underlock::Base.decrypt(encrypted_entity)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/metaware/underlock.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

