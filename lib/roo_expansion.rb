FILE_TYPE_HASH = {
	:excelx => ['xlsx'],
	:excel => ['xls'],
	:csv => ['csv']
}

def determine_file_type(filename)
	ext = filename.split('.').last
	FILE_TYPE_HASH.keys.each do |types|

	end
end

def get_ds_id(data_source_id)
	begin
		id = data_source_id['$oid']
	rescue
		id = data_source_id
	end
end