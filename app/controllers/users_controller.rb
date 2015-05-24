class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    user = User.find(params[:id])
    user.destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  def spotify
    #spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    # Now you can access user's private data, create playlists and much more
    #hash = spotify_user.to_hash
    # hash containing all user attributes, including access tokens

    spotify_user = request.env['omniauth.auth']
    #render :text => spotify_user.inspect
    #hash = spotify_user.to_hash #esto lo estaba usando en usuario.image para ver el contenido de hash
    usuario = User.new
    usuario.email = spotify_user.info.email
    usuario.name = spotify_user.info.name
    usuario.image = spotify_user.info.image
    usuario.otro = hash = spotify_user.to_hash

    usuario.save
    redirect_to users_url
    # Access private data
    #spotify_user.country #=> "US"
    #spotify_user.email   #=> "example@email.com"

    # Create playlist in user's Spotify account
    #playlist = spotify_user.create_playlist!('my-awesome-playlist')

    # Add tracks to a playlist in user's Spotify account
    #tracks = RSpotify::Track.search('Know')
    #playlist.add_tracks!(tracks)
    #playlist.tracks.first.name #=> "Somebody That I Used To Know"

    # Access and modify user's music library
    #spotify_user.save_tracks!(tracks)
    #spotify_user.saved_tracks.size #=> 20
    #spotify_user.remove_tracks!(tracks)

    # Use Spotify Follow features
    #spotify_user.follow(playlist)
    #spotify_user.follows?(artists)
    #spotify_user.unfollow(users)

    # Use the hash to persist the data the way you prefer...

    # Then recover the Spotify user whenever you like
    #spotify_user = RSpotify::User.new(hash)
    #spotify_user.create_playlist!('my_awesome_playlist') # automatically refreshes token

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :image)
    end

end
