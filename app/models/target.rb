class Target < ActiveRecord::Base
	validates :path, presence: true
	
	before_save :enqueue_now
	
	def full_path
	  if self.host.length > 0

	    # NOTE: this was a bit problematic before... didn't have a consistent expectation for which element had slashes and which didnt
	    #       now we expect all elements to have slashes where needed and don't add any in unexpectedly.  
	    #       for clarity:
	    #       BACKUP_BASE_PATH should at minimum be "/", if it includes a directory other than root it should have a 
	    #       trailing slash too. ie "/tmp/"
	    #       host does not have any slashes, ie "localhost"
	    #       path should start with a slash, ie "/file-in-root.txt" or "/directory/file-in-directory.txt"
	    
	    # TODO (maybe?):  remove double slashes? 
	    
	    "#{BACKUP_BASE_PATH}#{self.host}#{self.path}"
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
