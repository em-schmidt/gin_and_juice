# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary server in each group
# is considered to be the first unless any hosts have the primary
# property set.  Don't declare `role :all`, it's a meta role.

role :app, %w{deploy@prod-backup.prod1.parature.com}
role :web, %w{deploy@prod-backup.prod1.parature.com}
role :db,  %w{deploy@prod-backup.prod1.parature.com}
role :woker,  %w{deploy@prod-backup.prod1.parature.com}
role :resque_worker, %w{deploy@prod-backup.prod1.parature.com}
role :resque_scheduler, %w{deploy@prod-backup.prod1.parature.com}

set :resque_environment_task, true
set :workers, {"fs_crawler_queue" => 1,"scheduler" => 1, "s3_queue" => 5}


set :rails_env, :production
set :full_app_name, "#{fetch(:application)}_#{fetch(:stage)}"
set :server_name, "prod-backup.prod1.parature.com"

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server definition into the
# server list. The second argument is a, or duck-types, Hash and is
# used to set extended properties on the server.

server 'prod-backup.prod1.parature.com', user: 'deploy', roles: %w{web app worker}


# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult[net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start).
#
# Global options
# --------------
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
#
# And/or per server (overrides global)
# ------------------------------------
# server 'example.com',
#   user: 'user_name',
#   roles: %w{web app},
#   ssh_options: {
#     user: 'user_name', # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: 'please use keys'
#   }
