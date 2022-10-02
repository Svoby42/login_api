# config valid for current version and patch releases of Capistrano
lock "~> 3.17.1"

set :application, "login_api"
# password:username IS NO LONGER ACCEPTED
# you have to USE your TOKEN INSTEAD
set :repo_url, "https://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@github.com/Svoby42/login_api.git"
set :rvm_ruby_version, "ruby-3.1.2"
set :default_env, { rvm_bin_path: "~/.rvm/bin" }

namespace :deploy do
  desc "Run seed"
  task :seed do
    on roles(:all) do
      within current_path do
        execute :bundle, :exec, 'rails', 'db:seed', 'RAILS_ENV=production'
      end
    end
  end

  after :migrating, :seed
end

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", 'config/master.key'

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "tmp/webpacker", "public/system", "vendor", "storage"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
