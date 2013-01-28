# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'stew/version'

Gem::Specification.new do |gem|
  gem.name          = "stew"
  gem.version       = Stew::VERSION
  gem.authors       = ["Magnus Skog"]
  gem.email         = ["magnus.m.skog@gmail.com"]
  gem.description   = "A simple gem for communicating with the Steam gaming service"
  gem.summary       = "A simple gem for communicating with the Steam gaming service"
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'guard'
  gem.add_development_dependency 'guard-rspec'
  gem.add_development_dependency 'vcr'
  gem.add_development_dependency 'webmock'
  gem.add_development_dependency 'ci_reporter'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'simplecov-rcov'
  gem.add_development_dependency 'multi_xml'
  gem.add_development_dependency 'rb-inotify'

  gem.add_runtime_dependency 'nokogiri'
  gem.add_runtime_dependency 'faraday'
  gem.add_runtime_dependency 'faraday_middleware'
  gem.add_runtime_dependency 'money'
end
