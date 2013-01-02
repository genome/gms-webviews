# swiped this capfile from this doc:
# http://kris.me.uk/2011/10/28/rails-rvm-passenger-capistrano-git-apache.html

# RVM bootstrap
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require 'rvm/capistrano'
set :rvm_ruby_string, '1.9.3-p362'

# bundler bootstrap
require 'bundler/capistrano'

# main details
set :application, "vmpool85"
role :web, "vmpool85"
role :app, "vmpool85"
role :db,  "vmpool85", :primary => true

# server details
default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :deploy_to, "/var/www/gms-webviews"
set :deploy_via, :remote_cache
set :user, "passenger"
ssh_options[:keys] = [File.join(ENV["HOME"], "ssh-keys", "passenger@rails-webviews")]
set :use_sudo, false

# repo details
set :scm, :git
#set :scm_username, "passenger"
set :repository, "https://github.com/genome/gms-webviews.git"
set :branch, "master"
set :git_enable_submodules, 1

# tasks
namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end
  
  desc "Shuffle database config file"
  task :db_relink, :roles => :app do
    run "ln -nfs /home/passenger/database.yml #{release_path}/config/database.yml"
  end
end

after 'deploy:update_code', 'deploy:db_relink'
