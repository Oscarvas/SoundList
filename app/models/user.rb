class User
  include Mongoid::Document
  field :provider, :type => String
  field :uid, :type => String
  field :name, type: String
  field :email, type: String
  field :image, type: String
  field :saved, type: Array
  #has_many :song

  validates_uniqueness_of :email

  def self.create_with_omniauth(auth)
	create! do |user|
		user.provider = auth['provider']
		user.uid = auth['uid']
		if auth['info']
		   user.name = auth['info']['name'] || ""
		   user.email = auth['info']['email'] || ""
		   user.image = auth['info']['image'] || ""

		   user.saved = Array.new
		   spoty = RSpotify::User.new(auth)
		   spoty.saved_tracks.each do |prev|
		   	user.saved << { title: prev.name, artist: prev.artists.first.name, preview_url: prev.preview_url}
		   end
		end
	end
  end

  #mopped problem
  class << self
  	def serialize_from_session(key, salt)
  		record = to_adapter.get(key[0]["$oid"])
  		record if record && record.authenticatable_salt == salt
  	end
  end

  private

  def user_params
  	params.require(:user).permit(:uid, :email, :name, :saved, :image, :provider)
  end

end
