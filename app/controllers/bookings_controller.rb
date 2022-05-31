class BookingsController < ApplicationController
  before_action :find_pokemon, only: [:new, :create]

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.pokemon = @pokemon
    if @booking.save
      redirect_to profile_users_path
    else
      render 'pokemons/show', status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:date, :pokemon_id)
  end

  def find_pokemon
    @pokemon = Pokemon.find(params[:pokemon_id])
  end
end
