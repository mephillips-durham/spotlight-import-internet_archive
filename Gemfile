source 'https://rubygems.org'

# Specify your gem's dependencies in spotlight-import-internet_archive.gemspec
gemspec


group :test do
  gem 'simplecov', require: false
  gem 'coveralls', require: false
  gem 'devise'
  gem 'devise-guests'
  gem "bootstrap-sass"
  gem 'turbolinks'
  gem 'jquery-rails'
end
if File.exists?('spec/test_app_templates/Gemfile.extra')
  eval File.read('spec/test_app_templates/Gemfile.extra'), nil, 'spec/test_app_templates/Gemfile.extra'
end