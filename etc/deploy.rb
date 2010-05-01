set :application, "taipei.pm"
set :repository,  "git://github.com/c9s/taipei.pm.git"


set :deploy_to, "/usr/home/apps/#{application}"
set :scm, :git
set :use_sudo, false
set :deploy_via, :remote_cache
set :user, "apps"

role :app, "mozart.osdc.tw"
role :web, "mozart.osdc.tw"
role :db,  "mozart.osdc.tw", :primary => true

namespace :deploy do
  desc "Create database.yml and asset packages for production"
  task :after_update_code, :roles => [:web] do
    run "cp -r #{shared_path}/etc/* #{current_path}/etc/"
  end

  desc "Restart the server"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{shared_path}/bin/twiggy_stop.sh"
    run "#{shared_path}/bin/twiggy_start.sh"
  end

  desc "Start the server"
  task :start, :roles => :app, :except => { :no_release => true } do
    run "#{shared_path}/bin/twiggy_start.sh"
  end

  desc "Stop the server"
  task :stop, :roles => :app, :except => { :no_release => true } do
    run "#{shared_path}/bin/twiggy_stop.sh"
  end

  task :migrate, :roles => :app do
    run "cd #{current_path}; bin/jifty schema --setup"
  end

  [:finalize_update].each do |t|
    desc "#{t} task is a no-op."
    task t, :roles => :app do ; end
  end
end
