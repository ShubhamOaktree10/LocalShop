class CategoriesController < ApplicationController
	before_action :set_shop, :check_role
	def index
		@categories = Category.where("shop_id = ?",@shop.id)
	end

	def new
		@category = Category.new
	end

	def create
		@category = Category.new(category_params)
    @category.save
    @category.shop_id = @shop.id
    if @category.save
		  redirect_to user_shop_categories_path(current_user, @shop)
    else
      render :new
    end
	end

  def edit
    @category = @shop.categories.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to user_shop_categories_path(current_user, @shop)
    else
      render :edit
    end
  end

	private
  
  def set_shop
    @shop = Shop.find(params[:shop_id])
  end

	def category_params
		params.require(:category).permit(:name)
	end

  def check_role
    @role = Role.find_by_user_id(current_user.id)
    if(@role.name != "seller")
      redirect_to reusers_path
    end
  end
end
