class User
  include Mongoid::Document
  field :name, type: String
  field :email, type: String
  field :age, type: Integer
  field :genero, type: String
  field :sexo, type: String
  embedded_in :song
end
