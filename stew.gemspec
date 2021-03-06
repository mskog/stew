# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'stew/version'

Gem::Specification.new do |gem|
  gem.name          = "stew"
  gem.version       = Stew::VERSION
  gem.authors       = ["Magnus Skog"]
  gem.email         = ["magnus.m.skog@gmail.com"]
  gem.description   = "Accesses the Steam Community API as well as the Store. Can show games for profiles as well as parsed HTML data for applications and sales"
  gem.summary       = "A client for the Steam Gaming service."
  gem.homepage      = "https://github.com/mskog/stew"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency 'multi_xml'
  gem.add_runtime_dependency 'nokogiri', '>= 1.5.0'
  gem.add_runtime_dependency 'faraday', '>= 0.8.6'
  gem.add_runtime_dependency 'faraday_middleware', '>= 0.9.0'
  gem.add_runtime_dependency 'money', '>= 5.1.0'


  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'guard'
  gem.add_development_dependency 'guard-rspec'
  gem.add_development_dependency 'vcr'
  gem.add_development_dependency 'webmock'
  gem.add_development_dependency 'ci_reporter'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'simplecov-rcov'
  gem.add_development_dependency 'rb-inotify'
  gem.add_development_dependency 'yard'
  gem.add_development_dependency 'rdiscount'

end
