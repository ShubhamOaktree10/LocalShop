class QuantitiesController < ApplicationController
	before_action :set_shop, :set_category, :set_product, :check_role
	def index
		@quantity = Quantity.find_by_product_id(@product.id)
	end

  def new
    @quantity = Quantity.new
  end

  def create
    @quantity = Quantity.new(quantity_params)
    @quantity.save
    @quantity.product_id = @product.id
    if @quantity.save
      redirect_to user_shop_category_product_quantities_path(current_user, @shop, @category, @product)
    else 
      render :new
    end
  end

  def edit
    @quantity = Quantity.find(params[:id])
  end

  def update
    @quantity = Quantity.find(params[:id])
    if @quantity.update(quantity_params)
      redirect_to user_shop_category_product_quantities_path(current_user, @shop, @category, @product)
    else
      render :edit
    end
  end

	private
	def set_shop
		@shop = Shop.find(params[:shop_id])
	end

	def set_category
		@category = Category.find(params[:category_id])
  end

  def set_product
    @product = Product.find(params[:product_id])
  end
  
  def quantity_params
    params.require(:quantity).permit(:total)
  end

  def check_role
    @role = Role.find_by_user_id(current_user.id)
    if(@role.name != "seller")
      redirect_to reusers_path
    end
  end
end
