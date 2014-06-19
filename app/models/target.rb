class Target < ActiveRecord::Base
	validates :path, presence: true
	
	before_save :enqueue_now
	
	def full_path
	  if self.host.length > 0
	    "#{BASE_PATH}/#{self.host}#{self.path}"
	 else
	    self.path
    end
	end
	
	def backup_due?
	  if (Time.now.to_i - self.last_backup) > self.backup_interval
	    true
    else
      false
    end
  end
	
	def backup_now!
	  last_backup_will_change!
	  Resque.enqueue(FsCrawler, self.full_path, self.max_cache_age)
	  self.last_backup = Time.now.to_i
	  self.queue_now = false
	  self.save
  end
	
	protected
	
	def enqueue_now
	  self.backup_now! if self.queue_now?
	end
	
end
