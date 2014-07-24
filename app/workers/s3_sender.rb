class S3Sender
	@queue = :s3_queue
	
	def self.perform(file_path)
        begin
            f = File.open(file_path, 'r')	  
            digest = Digest::MD5.new()
            f.each_line { |line| digest << line }

            if f.size > 52428800
            aws_file = S3.files.create(:key => file_path, :body => open(file_path), :encryption => 'AES256', :multipart_chunk_size => 52428800)
            else
            aws_file = S3.files.create(:key => file_path, :body => open(file_path), :encryption => 'AES256')
            end

            cache_entry = {cache_create_time: Time.now.to_i,
                         fs_create_time: f.ctime.to_i,
                       fs_size: f.size,
                       fs_md5: digest.to_s,
                       aws_etag: aws_file.etag,
                       aws_create_time: Time.now.to_i }

            STAT_CACHE[file_path] = cache_entry.to_json

            Rails.logger.info "S3Sender sent #{file_path} md5: #{digest.to_s} etag: #{aws_file.etag}"
        rescue Errno::ENOENT => e
            Rails.logger.error "S3Sender: #{e.message}"
        rescue Errno::EACCESS => e
            Rails.logger.errror "S3Sender: #{e.message}"
        end


	end


end
