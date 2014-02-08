# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'spotlight/import/internet_archive/version'

Gem::Specification.new do |spec|
  spec.name          = "spotlight-import-internet_archive"
  spec.version       = Spotlight::Import::InternetArchive::VERSION
  spec.authors       = ["Chris Beer"]
  spec.email         = ["chris@cbeer.info"]
  spec.summary       = %q{TODO: Write a short summary. Required.}
  spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rails"
  spec.add_dependency "blacklight"
  spec.add_dependency "faraday"
  spec.add_dependency "faraday_middleware"
  spec.add_dependency "nokogiri"
  spec.add_dependency "cancan"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "capybara"
  spec.add_development_dependency "poltergeist"
  spec.add_development_dependency "factory_girl"
  spec.add_development_dependency "engine_cart", ">= 0.1.3"
  spec.add_development_dependency "database_cleaner", "< 1.1.0"
  spec.add_development_dependency "jettywrapper"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "simplecov"
end
