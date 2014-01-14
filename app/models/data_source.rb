class DataSource
  include Mongoid::Document
  belongs_to :data_source_type
  before_save :set_ip_address

  belongs_to :user
  has_one :ingredient

  validates_presence_of :name, :data_file

  field :name
  field :coordinates, :type => Array
  field :ip_address
  field :location
  field :image
  field :status
  field :preview, :type => Hash
  field :header_row

  TYPES = [:file, :api]

  include Geocoder::Model::Mongoid
  geocoded_by :address

  mount_uploader :data_file, FileUploader

  def address
  	self.location || self.ip_address	
  end


  private

  def set_ip_address
    self.ip_address = self.user.last_ip || ""
  end
end
