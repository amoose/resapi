class User 
  include Mongoid::Document
  field :name, type: String
  field :email, type: String
  field :username, type: String
  field :avatar, type: String
  field :last_ip, type: String
  
  has_many :authentications
  has_many :data_sources
  has_many :ingredients

  def self.create_with_omniauth(auth)
    create! do |user|
    	user.username = auth[:info][:nickname]
    	user.email = auth[:info][:email]
    	user.name = auth[:info][:name] || auth[:info][:nickname]
    	user.avatar = auth[:info][:avatar]
      user.authentications << Authentication.create!(:uid => auth[:uid], :provider => auth[:provider])
    end
  end
end
