class S3Sender
	@queue = :s3_queue
	
	def self.perform(file_path)
	  S3.files.create(:key => file_path, :body => open(file_path))
	end


end