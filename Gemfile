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
gem "database_cleaner"
gem "database_cleaner-active_record"

gem "bcrypt", "~> 3.1.7"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false

gem "capistrano-rvm"
gem "capistrano-secrets-yml"

gem "ed25519", "~> 1.2"
gem "bcrypt_pbkdf", "~> 1.0"

group :development do
  gem "capistrano", "~> 3.10", require: false
  gem "capistrano-rails", "~> 1.3", require: false
end

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "minitest-reporters"
  gem "rspec-rails"
end

group :test do

end


gem "active_model_serializers", "~> 0.10.13"
