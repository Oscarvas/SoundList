class User
  include Mongoid::Document
  field :provider, :type => String
  field :uid, :type => String
  field :name, type: String
  field :email, type: String
  field :image, type: String

  has_many :songs

  validates_uniqueness_of :email

  def self.create_with_omniauth(auth)
	create! do |user|
		user.provider = auth['provider']
		user.uid = auth['uid']
		if auth['info']
		   user.name = auth['info']['name'] || ""
		   user.email = auth['info']['email'] || ""
		   user.image = auth['info']['image'] || ""

		   spoty = RSpotify::User.new(auth)
		   spoty.saved_tracks.each do |prev|
        user.songs << Song.new( name: prev.name, preview: prev.preview_url, artist: prev.artists.first.name)
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
  	params.require(:user).permit(:uid, :email, :name, :image, :provider)
  end

end
