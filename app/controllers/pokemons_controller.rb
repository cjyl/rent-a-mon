class PokemonsController < ApplicationController
  def index
    @pokemons = Pokemon.all
  end
end
