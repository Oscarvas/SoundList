json.array!(@songs) do |song|
  json.extract! song, :id, :name, :genero :duracion :cantante : like
  json.url song_url(song, format: :json)
end
