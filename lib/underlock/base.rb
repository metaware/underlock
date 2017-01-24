require 'dry-configurable'

module Underlock
  class Base
    extend Dry::Configurable

    setting :private_key
    setting :public_key
  end
end