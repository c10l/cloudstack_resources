# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cloudstack-rb/version'
require 'date'

Gem::Specification.new do |gem|

  gem.name        = 'cloudstack-rb'
  gem.version     = CloudStackRB::VERSION
  gem.date        = Date::today.to_s
  gem.summary     = "ActiveResource-like abstraction to fiddle with CloudStack"
  gem.description = gem.summary
  gem.authors     = ["Cassiano Leal"]
  gem.email       = 'cassianoleal@gmail.com'
  gem.homepage    = 'http://rubygems.org/gems/cloudstack-rb'
  gem.license     = 'MIT'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'cloudstack_ruby_client'

  gem.add_development_dependency 'pry'

end
