# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.3.0'

gem 'bootsnap', require: false
gem 'httparty'
gem 'pg', '~> 1.1'
gem 'puma', '>= 5.0'
gem 'rails', '~> 7.1.3', '>= 7.1.3.2'

group :development, :test do
  gem 'dotenv-rails', '~> 3.1'
  gem 'factory_bot_rails', '~> 6.2'
  gem 'pry'
  gem 'rspec-rails'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
end

group :development do
  gem 'spring'
  gem 'spring-commands-rspec'
end

group :test do
  gem 'shoulda-matchers', '~> 6.1'
  gem 'webmock', '~> 3.19', '>= 3.19.1'
end
