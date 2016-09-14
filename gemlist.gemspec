# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gemlist/version'

Gem::Specification.new do |spec|
  spec.name          = "gemlist"
  spec.version       = Gemlist::VERSION
  spec.authors       = ["Chris Hoffman"]
  spec.email         = ["yarmiganosca@gmail.com"]

  spec.summary       = "Get a list of gems Bundler would install."
  spec.description   = "Get a list of gems Bundler would install under various conditions. Built to be used in build tools."
  spec.homepage      = "https://www.github.com/yarmiganosca/gemlist"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry-byebug"

  spec.add_runtime_dependency "rubytree", "~> 0.9.7"
end
