class FavoritesController < ApplicationController
	before_action :set_role
	
  def index
    @favorites = Favorite.where("user_id = ?", current_user.id)
  end

  def create
		@favorite = Favorite.create(product_id:params[:product_id], user_id:current_user.id)
    respond_to do |format|
      format.html { redirect_to reusers_path, alert: "Remove From Favorite" }
      format.json { head :no_content }
      format.js   { render :layout => false }
     end
	end

  def destroy
    @favorite = Favorite.find(params[:id])
    @favorite.destroy
    respond_to do |format|
      format.html { redirect_to favorites_path, alert: "Remove From Favorite" }
      format.json { head :no_content }
      format.js   { render :layout => false }
     end
  end

  private
	def set_role
    @role = Role.find_by_user_id(current_user.id)
  end 
end
