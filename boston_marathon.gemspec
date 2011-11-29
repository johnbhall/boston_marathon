# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "boston_marathon/version"

Gem::Specification.new do |s|
  s.name        = 'boston_marathon'
  s.version     = BostonMarathon::VERSION
  s.platform    = Gem::Platform::RUBY
  s.date        = '2011-11-25'
  s.summary     = "Ruby wrapper for race results from the 2011 Boston Marathon"
  s.authors     = ["John B. Hall"]
  s.email       = 'johnbrianhall@gmail.com'
  
  s.add_runtime_dependency 'rest-client', '= 1.6.7'
  s.add_runtime_dependency 'nokogiri', '= 1.5.0'
  
  s.add_development_dependency 'redgreen', ">= 1.2.2"
  s.add_development_dependency 'vcr', '1.11.3'
  s.add_development_dependency 'fakeweb', '1.3.0'
  s.add_development_dependency 'shoulda-context', '~> 1.0.0'
  
  s.require_paths = ["lib"]
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
end