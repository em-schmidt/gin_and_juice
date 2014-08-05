require 'find'
require 'resque/plugins/lock'

class FsCrawler
  extend Resque::Plugins::Lock

  @queue = :fs_crawler_queue

  def self.perform(fs_full_path, max_cache_age)
    stat_cache = Redis::Namespace.new(:statcache)
    Rails.logger.info "FSCrawler Starting crawl of path: #{fs_full_path}" 
    Find.find(fs_full_path) do |path| 
      if File.file?(path)
        full_path = File.expand_path(path)
        cache_entry = stat_cache.get(full_path)
        if cache_entry.nil?
          Rails.logger.info "FsCrawler path: #{full_path} not in stat cache, enqueueing"
          Resque.enqueue(S3Sender, full_path)
        else
          cache_create_time = JSON.parse(cache_entry)["cache_create_time"]
          if (Time.now.to_i - cache_create_time) > max_cache_age
            Rails.logger.info "FsCrawler path: #{full_path} cache_age: #{Time.now.to_i - cache_create_time} max_cache_age: #{max_cache_age}, enqueueing"
            Resque.enqueue(S3Sender, File.expand_path(path))
            else
              Rails.logger.info "FsCrawler path: #{full_path} cache_age: #{Time.now.to_i - cache_create_time} max_cache_age: #{max_cache_age}, skipping"
          end
        end
      end
    end
    Rails.logger.info "FSCrawler Finished crawl of path: #{fs_full_path}"
  end 
end 
