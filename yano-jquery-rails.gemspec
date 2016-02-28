# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yano/jquery/rails/version'

Gem::Specification.new do |spec|
  spec.name          = "yano-jquery-rails"
  spec.version       = Yano::Jquery::Rails::VERSION
  spec.platform      = Gem::Platform::RUBY
  spec.authors       = ["Jonathan C. Calixto"]
  spec.email         = ["jonathanccalixto@gmail.com"]

  spec.summary       = "Use jQuery and jQueryUI with Rails 4+"
  spec.description   = "This gem provides jQuery, jQuery and the jQuery-ujs driver for your Rails 4+ application."
  spec.homepage      = "http://rubygems.org/gems/yano-jquery-rails"
  spec.license       = "MIT"

  spec.required_ruby_version = ">= 1.9.3"
  spec.required_rubygems_version = ">= 1.3.6"

  spec.add_dependency "railties", ">= 4.2.0"
  spec.add_dependency "thor",     ">= 0.14", "< 2.0"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
