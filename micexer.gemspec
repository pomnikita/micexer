# -*- encoding: utf-8 -*-
require File.expand_path('../lib/micexer/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Nikita Pomyashchiy"]
  gem.email         = ["pomnikita@gmail.com"]
  gem.description   = ''
  gem.summary       = ''
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "micexer"
  gem.require_paths = ["lib"]
  gem.version       = Micexer::VERSION
  
  gem.add_development_dependency 'rspec-rails'
  gem.add_development_dependency 'webmock'
  gem.add_development_dependency 'vcr'

end
