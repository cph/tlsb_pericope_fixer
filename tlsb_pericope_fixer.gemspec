# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tlsb_pericope_fixer/version'

Gem::Specification.new do |gem|
  gem.name          = "tlsb_pericope_fixer"
  gem.version       = TlsbPericopeFixer::VERSION
  gem.authors       = ["Robert Lail"]
  gem.email         = ["robert.lail@cph.org"]
  gem.description   = %q{Looks for Bible reference links in TLSB XML, parses the reference, and writes the correct link}
  gem.summary       = %q{A script to fix bible references in the TLSB XML }
  gem.homepage      = ""
  
  gem.add_dependency "pericope"
  
  gem.add_development_dependency "rails", "~> 3.2.8"
  gem.add_development_dependency "turn"
  gem.add_development_dependency "pry"
  
  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
