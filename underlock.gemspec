# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'underlock/version'

Gem::Specification.new do |spec|
  spec.name          = "underlock"
  spec.version       = Underlock::VERSION
  spec.authors       = ["Jasdeep Singh"]
  spec.email         = ["narang.jasdeep@gmail.com"]

  spec.summary       = %q{Underlock makes it dead simple to encrypt and decrypt files using public/private keys.}
  # spec.description   = %q{}
  spec.homepage      = "https://github.com/metaware/underlock"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "dry-configurable", "~> 0.5.0"

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "yomu", "~> 0.2.4"
  spec.add_development_dependency "pry", "~> 0.10.4"
end
