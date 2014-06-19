class FsCrawler

  @queue = :fs_crawler_queue
  
  def self.perform(fs_full_path, max_cache_age)
    Dir.chdir(fs_full_path) do 
      Dir.glob("**/*").map do |path| 
        if File.file?(path)
          full_path = File.expand_path(path)
          puts "checking path: #{full_path}"
          cache_entry = STAT_CACHE.get(full_path)
          if cache_entry.nil?
            Resque.enqueue(S3Sender, full_path)
          else
            cache_create_time = JSON.parse(cache_entry)["cache_create_time"]
            if (Time.now.to_i - cache_create_time) > max_cache_age
              puts "now: #{Time.now.to_i} cache_age: #{Time.now.to_i - cache_create_time} max_cache_age: #{max_cache_age}"
              Resque.enqueue(S3Sender, File.expand_path(path))
            end 
          end 
        end 
      end 
    end 
  end 
end 