# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
GinAndJuice::Application.initialize!

if defined?(PhusionPassenger)
  PhusionPassenger.on_event(:starting_worker_process) do |forked|
    if forked
      stat_cache.redis.client.reconnect
      Resque.redis.client.reconnect
    end
  end
end
