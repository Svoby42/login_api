source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

gem "rails", "~> 7.0.3"
gem "sqlite3", "~> 1.4"
gem "puma", "~> 5.0"

gem "jbuilder"
gem "httparty"
gem "jsonapi-resources"
gem "jwt"
gem "dotenv-rails"
gem "factory_bot_rails"
gem "faker"

gem "bcrypt", "~> 3.1.7"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "minitest-reporters"
  gem "rspec-rails"
end

group :test do
  gem "factory_bot_rails"
  gem "faker"
end


gem "active_model_serializers", "~> 0.10.13"
