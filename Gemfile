# frozen_string_literal: true
source 'https://rubygems.org'
ruby '2.3.1'

gem 'sinatra'
gem 'puma'
gem 'json'
gem 'econfig'
gem 'rake'

gem 'share_learning'
gem 'sequel'
gem 'roar'
gem 'multi_json'
gem 'dry-monads'
gem 'dry-container'
gem 'dry-transaction'

gem 'tux'
gem 'hirb'

gem 'aws-sdk', '~> 2'
gem 'shoryuken'

group :development, :test do
  gem 'pry-byebug'
  gem 'sqlite3'
end

group :development do
  gem 'rerun'

  gem 'flog'
  gem 'flay'
end

group :test do
  gem 'minitest'
  gem 'minitest-rg'

  gem 'rack-test'

  gem 'vcr'
  gem 'webmock'
end

group :production do
  gem 'pg'
end
