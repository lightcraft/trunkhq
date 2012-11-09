set :directory, "production"
set :branch, "master"
set :deploy_to, "/var/www/#{directory}"
set :rails_env, 'production'
#set :delayed_job_args, '-i 1'