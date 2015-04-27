class Song
  include Mongoid::Document
  field :name, type: String
  field :genero, type: String
  field :duracion, type: Integer
  field :cantante, type: String
  field :like, type: String
end
