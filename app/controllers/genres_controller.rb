class GenresController < ApplicationController
  require 'echonest-ruby-api'
  skip_before_filter :getArtist  
   # GET /genres
  # GET /genres.json
  def index
    
  end

  def get
    
  end
  # GET /genres/1
  # GET /genres/1.json
  def show
  end

  # GET /genres/new
  def new
    @genre = Genre.new
  end

  # GET /genres/1/edit
  def edit

  end

  def aaa 
    
    respond_to do |format|
      format.html # contact.html.erb
      format.json {
        render :response => {:par => par}
      }
    end
  end

  # POST /genres
  # POST /genres.json
  def create
    @genre = Genre.new(genre_params)

    respond_to do |format|
      if @genre.save
        format.html { redirect_to @genre, notice: 'Genre was successfully created.' }
        format.json { render :show, status: :created, location: @genre }
      else
        format.html { render :new }
        format.json { render json: @genre.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /genres/1
  # PATCH/PUT /genres/1.json
  def update
    respond_to do |format|
      if @genre.update(genre_params)
        format.html { redirect_to @genre, notice: 'Genre was successfully updated.' }
        format.json { render :show, status: :ok, location: @genre }
      else
        format.html { render :edit }
        format.json { render json: @genre.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /genres/1
  # DELETE /genres/1.json
  def destroy
    @genre.destroy
    respond_to do |format|
      format.html { redirect_to genres_url, notice: 'Genre was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def getArtist 
    genr = params [:gen]
    respond_to do |format|
      format.html # contact.html.erb
      format.json {
        render :response => {:gen => genr}
      }
    end
    lista_generos = []
    genr.each do |generisimo|
      lista_generos.push (generisimo)
      similar = Echonest::Genre.similar('S6YKWF6QCDG012BBJ', generisimo, result: 5)
      g = similar.to_json
      json = JSON.parse (g)
      json['genres'].each do |genress| 
        genr.push (genress['name'])
      end
    end
    lista_artistas = []
    lista_generos.each do |genero|
      artist = Echonest::Genre.artist('S6YKWF6QCDG012BBJ', genero, result: 10)
      g = artist.to_json
      json = JSON.parse (g)
      json['artists'].each do |a| 
        lista_artistas << a['id']
      end
    end
    lista_canciones = []
    lista_artistas.each do |artista|
      song = Echonest::Artist.songs('S6YKWF6QCDG012BBJ', artista, result: 3)
      g = artist.to_json
      json = JSON.parse (g)
      json['songs'].each do |a| 
      lista_canciones << a['id']
      end
    end

  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_genre
      @genre = Genre.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def genre_params
      params.require(:genre).permit(:name)
    end
end
