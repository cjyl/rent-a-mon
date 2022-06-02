class ReviewsController < ApplicationController

  def create
    @review = Review.new(review_params)
    @pokemon = Pokemon.find(params[:pokemon_id])
    @review.pokemon = @pokemon
    if @review.save
      redirect_to pokemon_path(@pokemon)
    else
      @review = Review.new
      render ‘pokemons/show’, status: :unprocessable_entity
    end
  end

  # def destroy
  #   @review = Review.find(params[:id])
  #   @review.destroy
  #   redirect_to list_path(@review.list)
  # end

  private

  def review_params
    params.require(:review).permit(:content, :rating, :pokemon_id)
  end
end
