class PokemonsController < ApplicationController
  def index
    @pokemons = Pokemon.all
  end

  def new
    @pokemon = Pokemon.new
  end

  def create
    @pokemon = Pokemon.new(pokemon_params)
    @pokemon.user = current_user
    if @pokemon.save
      redirect_to pokemons_path
    else
      render 'new', status: :unprocessable_entity
    end
  end

  private

  def pokemon_params
    params.require(:pokemon).permit(:name, :element, :move, :location)
  end
end
