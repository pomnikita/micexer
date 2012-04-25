require 'micexer'
require 'webmock/rspec'

require 'support/helpers'
require 'support/vcr'

RSpec.configure do |config|
  config.extend VCR::RSpec::Macros
  config.include Helpers
end
