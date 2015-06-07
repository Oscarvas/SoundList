class SessionsController < ApplicationController
  def new
  	redirect_to '/auth/spotify'
  end

  def create
  	auth = request.env["omniauth.auth"]
  	user = User.where(:provider => auth['provider'],
  		:uid => auth['uid']).first || User.create_with_omniauth(auth)
  	session[:user_id] = user.id

  	if !user.email
  		redirect_to edit_user_path(user), :alert => 'Please enter your email address.'
    else
      #spoty = RSpotify::User.new(auth)
      user.songs.destroy #cambio para actualizacion bruta
      #spoty.playlists.each do |play|

      spotify_user = RSpotify::User.new(auth)
      #Import playlists through RSpotify
      spotify_playlists = spotify_user.playlists
      spotify_playlists.each do |p|
        #este codigo añade las nuevas canciones que incorpore el usuario
        p.tracks.each do |pista|

          if user.songs.where(name: pista.name).count != 1
            user.songs << Song.new( name: pista.name, preview: pista.preview_url, artist: pista.artists.first.name)
            
            artistas = RSpotify::Artist.search(pista.artists.first.name)
            musico = artistas.first
            
            musico.genres.each do |genero|
              user.genres << Genre.new( name: genero)
            end

          end

        end
        #user.songs << Song.new( name: prev.name, preview: prev.preview_url, artist: prev.artists.first.name)
      end
  		redirect_to current_user#, :notice => 'Signed in!'#esto deberia redirigir a root_path
  	end 

  end

  def failure
  	redirect_to root_url, :alert => "Error en la autenticacion: #{params[:message].humanize}"
  end

  def destroy
  	reset_session
  	redirect_to root_url#, :notice => 'Signed out!'
  end

end
