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

```
Underlock::Base.configure do |config|
  config.public_key  = File.read('./spec/key.pub')
  config.private_key = File.read('./spec/key.priv')
  config.cipher      = OpenSSL::Cipher.new('aes-256-gcm')
end
```

For the `config.cipher` value, all algorithms available in `OpenSSL::Cipher.ciphers` are supported.

## Generating Public/Private keypair
```
key = OpenSSL::PKey::RSA.new 4096
puts key.to_pem
puts key.public_key.to_pem
```

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/metaware/underlock.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

