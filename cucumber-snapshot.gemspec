# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "cucumber-snapshot/version"
require "cucumber-snapshot"

Gem::Specification.new do |s|
  s.name        = "cucumber-snapshot"
  s.version     = CucumberSnapshot::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Nicolas NARDONE"]
  s.email       = ["nico.nardone@gmail.com"]
  s.homepage    = %q{http://github.com/nna/cucumber-snapshot}
  s.summary     = %q{Compare snapshots of cucumber features to check UI doesn't change}
  s.description = %q{Write a gem description}

  s.rubyforge_project = "cucumber-snapshot"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.post_install_message = 'CucumberSnapshot is not installed !'

  s.add_dependency('cucumber')
  s.add_dependency('capybara')
  s.add_dependency('rmagick')
end