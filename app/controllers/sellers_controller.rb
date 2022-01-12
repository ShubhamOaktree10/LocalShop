class SellersController < ApplicationController
	before_action :check_role
	def index
		if params[:q] != nil
      @products = Product.where("name = ?", params[:q])
      @favorites = Favorite.where("user_id = ?", current_user.id)
    else
      @products = Product.all
		  @favorites = Favorite.where("user_id = ?", current_user.id)
    end
	end

	private
	def check_role
		@role = Role.find_by_user_id(current_user.id)
    if(@role.name != "seller")
      redirect_to reusers_path
    end
	end
end
