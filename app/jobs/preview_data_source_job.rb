require 'roo_expansion'

class PreviewDataSourceJob

	@queue = :preview

  def self.perform(data_source_id)
  	begin
	  	data_source = DataSource.find(get_ds_id(data_source_id))
	  	data_source.status = "previewing"
	  	data_source.save
	  rescue
	  	Resque.logger.error "Error fetching DataSource with id: #{data_source_id}"
	  end

  	begin
			doc = Roo::Excelx.new("#{ENV['TEMP_DIR']}/#{data_source.id}/#{data_source['data_file']}")
		  doc.default_sheet = doc.sheets.first
		  preview = {}
		  0.upto(30) do |line|
		  	cols = (doc.first_column..doc.last_column)
		  	row = {}
		  	cols.each do |col|
		  		row.merge!(col => doc.cell(line,col))
		  	end
		  	preview.merge!(line => row)
		  end
		  data_source.preview = preview
		  data_source.status = "previewed"
		  data_source.save
		rescue
			data_source.status = "Error"
			data_source.save
			Resque.logger.error "Error previewing DataSource with id: #{data_source_id}"
		end

	  WebsocketRails["party_#{data_source.id.to_s}"].trigger(
	  	:event,
	  	{
	  		:status => data_source.status
	  	}
	  )
  end

end