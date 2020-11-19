class FavoritesController < ApplicationController

  def create
    favorite = current_user.favorites.build(room_id: params[:room_id])
    favorite.save
    redirect_back(fallback_location: rooms_path)
  end

  def destroy
    favorite = Favorite.find_by(room_id: params[:room_id], user_id: current_user.id)
    favorite.destroy
    redirect_back(fallback_location: rooms_path)
  end
end
