require "capistrano/setup"
require "capistrano/deploy"
require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git
require 'capistrano/bundler'
require 'capistrano/rails'     #(include assets, migrate)
require "capistrano/rbenv"
require 'capistrano/puma'
install_plugin Capistrano::Puma

#https://stackoverflow.com/questions/41307044/capistrano-dont-know-how-to-build-task-deploynew-release-path
install_plugin Capistrano::Puma::Daemon

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
