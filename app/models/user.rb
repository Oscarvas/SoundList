class User
  include Mongoid::Document
  #include Mongoid::Attributes::Dynamic
  field :name, type: String
  field :email, type: String
  field :image, type: String
  field :otro, type: String
  #embedded_in :song

  validates_uniqueness_of :email
end
