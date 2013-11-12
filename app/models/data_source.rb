class DataSource
  include Mongoid::Document
  belongs_to :data_source_type

  field :name
  field :coordinates, :type => Array
  field :ip_address
  field :location
  field :image

  include Geocoder::Model::Mongoid
  geocoded_by :address

  mount_uploader :data_file, FileUploader

  def address
  	self.location || self.ip_address	
  end
end
