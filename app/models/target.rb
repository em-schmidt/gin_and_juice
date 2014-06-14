class Target < ActiveRecord::Base
	validates :path, presence: true
	
	after_save :enqueue_now
	
	protected
	
	def enqueue_now
	  Resque.enqueue(FsCrawler, "/#{self.host}/#{self.path}") if self.queue_now?
	end
	
end
