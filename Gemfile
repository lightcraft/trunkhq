require 'rbconfig'
HOST_OS = RbConfig::CONFIG['host_os']
source 'https://rubygems.org'
gem 'rails', '3.2.4'
gem 'mysql2'
gem 'kaminari'
gem 'carrierwave'

group :development do
  gem 'awesome_print'
end

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem "haml", ">= 3.1.6"
gem "haml-rails", ">= 0.3.4", :group => :development
gem "rspec-rails", ">= 2.11.0", :group => [:development, :test]
gem "email_spec", ">= 1.2.1", :group => :test
gem "guard", ">= 0.6.2", :group => :development
gem "simplecov", :group => :test

gem "guard-bundler", ">= 0.1.3", :group => :development
gem "guard-rails", ">= 0.0.3", :group => :development
gem "guard-livereload", ">= 0.3.0", :group => :development
gem "guard-rspec", ">= 0.4.3", :group => :development
gem "faker", :group => :development
gem "devise", ">= 2.1.2"
gem "devise_invitable", ">= 1.0.2"
gem "cancan", ">= 1.6.8"
gem "rolify", ">= 3.1.0"
gem "bootstrap-sass", ">= 2.0.4.0"
gem "simple_form"
gem "rails-footnotes", ">= 3.7", :group => :development
gem "therubyracer", :group => :assets, :platform => :ruby

# Deploy with Capistrano
gem 'capistrano'
gem 'capistrano-ext'
