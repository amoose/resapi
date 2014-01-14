class DownloadDataSourceJob

	@queue = :download

	def self.perform(data_source_id)
  	data_source = DataSource.find(get_ds_id(data_source_id))
  	`mkdir -p tmp/#{data_source.id}`
		uri = URI(ENV['AWS_S3_BUCKET'] + '/' + data_source.data_file.path)
		data_source.status = "downloading"
		Net::HTTP.start(uri.host, uri.port) do |http|
		  request = Net::HTTP::Get.new uri.request_uri

		  http.responsequest request do |response|
		    open "#{ENV['TEMP_DIR']}/#{data_source.id}/#{data_source['data_file']}", 'wb' do |io|
		      response.read_body do |chunk|
		        io.write chunk
		      end
		    end
		  end
		end
		# 
	  data_source.status = "downloaded"
	  data_source.save
	  Resque.enqueue(PreviewDataSourceJob, data_source.id)
	end
end