class Song
  include Mongoid::Document
  field :name, type: String
  field :preview, type: String
  field :artist, type: String
  field :like, type: Boolean

  belongs_to :user
end
