Resque::Scheduler.dynamic = true
Resque.schedule = YAML.load_file(File.join('config/scheduler.yml'))

