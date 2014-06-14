class FsCrawler

  @queue = :fs_crawler_queue
  
  def self.perform(fs_full_path)
    Dir.chdir(fs_full_path) do 
      Dir.glob("**/*").map { |path| Resque.enqueue(S3Sender, File.expand_path(path)) if File.file?(path) }
    end
  end

end