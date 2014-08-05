Resque::Scheduler.dynamic = true
Resque.schedule = YAML.load_file(File.join('config/scheduler.yml'))

Resque.after_fork do
    Resque.redis.client.reconnect
end
