class ShopsController < ApplicationController
	before_action :check_role
	def index
		@shops = Shop.all
	end
    
  def show
  	@shop = Shop.find(params[:id])
  end

	def new
		@shop = Shop.new
	end

	def create		
		@shop = current_user.shops.create(shop_params)
		redirect_to user_shops_path(current_user)
	end

  def edit
    @shop = current_user.shops.find(params[:id])
  end

  def update
    @shop = current_user.shops.find(params[:id])

    if @shop.update(shop_params)
      redirect_to user_shop_path(@shop)
    else
      render :edit
    end
  end

	private
	def check_role
		@role = Role.find_by_user_id(current_user.id)
    if(@role.name != "seller")
      redirect_to reusers_path
    end
	end
	
	def shop_params
		params.require(:shop).permit(:name, :city, :state, :country, :pincode)
	end
end
