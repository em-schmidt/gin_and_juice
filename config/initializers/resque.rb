Resque::Scheduler.dynamic = true
Resque.schedule = YAML.load_file(File.join('config/scheduler.yml'))

Resque.before_fork do
    defined?(ActiveRecord::Base) and
        ActiveRecord::Base.connection.disconnect!
end

Resque.after_fork do
    defined?(ActiveRecord::Base) and
        ActiveRecord::Base.establish_connection
    Resque.redis.client.reconnect
end
