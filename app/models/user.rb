class User
  include Mongoid::Document
  field :provider, :type => String
  field :uid, :type => String
  field :name, type: String
  field :email, type: String
  field :image, type: String

  has_many :songs
  has_many :genres

  validates_uniqueness_of :email

  def self.create_with_omniauth(auth)
  	create! do |user|
  		user.provider = auth['provider']
  		user.uid = auth['uid']
  		if auth['info']
  		   user.name = auth['info']['name'] || ""
  		   user.email = auth['info']['email'] || ""
  		   user.image = auth['info']['image'] || ""
  		end
  	end
  end

  #mopped problem
  private

  def user_params
  	params.require(:user).permit(:uid, :email, :name, :image, :provider)
  end

end
