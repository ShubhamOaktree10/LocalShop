class BuyersController < ApplicationController
	before_action :check_role
	def index
    @products = Product.all
		@favorites = Favorite.where("user_id = ?", current_user.id)
    @product = Product.find_by_name(params["q"])
	end

  private 
  def check_role
    @role = Role.find_by_user_id(current_user.id)
    if(@role.name != "buyer")
      redirect_to reusers_path
    end
  end
end
