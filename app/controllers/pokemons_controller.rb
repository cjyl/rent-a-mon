class PokemonsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    if params[:query].present?
      sql_query = <<~SQL
      pokemons.name @@ :query
      OR pokemons.element @@ :query
      OR pokemons.address @@ :query
      OR users.first_name @@ :query
      OR users.last_name @@ :query
    SQL
    @pokemons = Pokemon.joins(:user).where(sql_query, query: "%#{params[:query]}%")
    else
      @pokemons = Pokemon.all
    end
    @markers = @pokemons.geocoded.map do |pokemon|
      {
        lat: pokemon.latitude,
        lng: pokemon.longitude,
        info_window: render_to_string(partial: "info_window", locals: { pokemon: pokemon }),
        image_url: (pokemon.image_path ? pokemon.image_path : pokemon.photo.key)
      }
    end
  end

  def new
    @pokemon = Pokemon.new
  end

  def show
    @pokemon = Pokemon.find(params[:id])
    @booking = Booking.new
  end

  def edit
    @pokemon = Pokemon.find(params[:id])
  end

  def update
    @pokemon = Pokemon.find(params[:id])
    @pokemon.user = current_user
    @pokemon.update(pokemon_params)
    redirect_to profile_users_path
  end

  def create
    @pokemon = Pokemon.new(pokemon_params)
    @pokemon.user = current_user
    if @pokemon.save
      redirect_to profile_users_path
    else
      render 'new', status: :unprocessable_entity
    end
  end

  private

  def pokemon_params
    params.require(:pokemon).permit(:name, :element, :move, :address, :photo)
  end
end
