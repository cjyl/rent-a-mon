class PokemonsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    @pokemons = Pokemon.all
    @markers = @pokemons.geocoded.map do |pokemon|
      {
        lat: pokemon.latitude,
        lng: pokemon.longitude,
        info_window: render_to_string(partial: "info_window", locals: { pokemon: pokemon })
      }
    end
  end

  def new
    @pokemon = Pokemon.new
  end

  def show
    @pokemon = Pokemon.find(params[:id])
    @booking = Booking.new
    @review = Review.new
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
