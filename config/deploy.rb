# -*- encoding : utf-8 -*-
set :application, "timbrandes"
set :domain, "185.21.103.209"
set :use_sudo, false
set :scm, :git
set :repository, "git@github.com:tibra/timbrandes.com.git"
set :deploy_via, :remote_cache
set :keep_releases, 3

# We have all components of the app on the same server
server domain, :app, :web, :db, :primary => true
# Answer yes to questions
set :default_run_options, {:pty => true}

set :branch, "master"
set :user, "static_timbrandes"
# Execute "bundle install" after deploy, but only when really needed
set :bundle_cmd, "/home/#{user}/.rvm/gems/#{rvm_ruby_string}/bin/bundle"
set :bundle_dir, "/home/#{user}/application/shared/bundle"
set :bundle_flags,    "--quiet --deployment"
set :deploy_to, "/home/#{user}/application"


# Must be down here under set :bundle_dir
require "bundler/capistrano"

# Install RVM and Ruby before deploy
before "deploy:setup", "rvm:install_rvm"
before "deploy:setup", "rvm:install_ruby"
after "deploy:setup", "deploy:touch_configs"

after "deploy", "deploy:restart"

# Clean-up old releases
after "deploy:restart", "deploy:cleanup"


namespace :deploy do

  task :touch_configs do
    run "mkdir -p #{shared_path}/log"
  end

end
