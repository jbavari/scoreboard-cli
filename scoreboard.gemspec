# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'scoreboard/version'

Gem::Specification.new do |spec|
  spec.name          = "scoreboard"
  spec.version       = Scoreboard::VERSION
  spec.authors       = ["Josh Bavari"]
  spec.email         = ["jbavari@gmail.com"]

  spec.summary       = %q{A commane line interface to conduct a scoreboard and report data to an API}
  spec.description   = %q{Start this command line tool, enter your home and visitor team, then start taking scores to see which team wins.}
  spec.homepage      = "http://jbavari.github.io"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'thor', '0.19.1'

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency 'reek'
end
