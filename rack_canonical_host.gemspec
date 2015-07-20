# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rack_canonical_host/version'

Gem::Specification.new do |spec|
  spec.name          = "rack_canonical_host"
  spec.version       = RackCanonicalHost::VERSION
  spec.authors       = ["Ryan McIlmoyl"]
  spec.email         = ["ryan.mcilmoyl@fivewalls.com"]

  spec.summary       = %q{Sets a single canonical domain name.}
  spec.description   = %q{Will redirect any incoming request to the defined domain name}
  spec.homepage      = "https://github.com/FXFusion/rack_canonical_host"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rack-test"

  spec.add_dependency "rack"
end
