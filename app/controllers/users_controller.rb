class UsersController < ApplicationController
  def profile
    redirect_to root_path unless current_user
  end
end
