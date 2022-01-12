class ProductsController < ApplicationController
	before_action :set_shop, :set_category, :check_role	

  def index
    @products = Product.where("category_id = ?",@category.id)
  end

  def new
  	@product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.save
    @product.category_id = @category.id
    if @product.save
      redirect_to user_shop_category_products_path(current_user, @shop, @category)
    else 
      render :new
    end
  end
  
  def edit
    @product = @category.products.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to user_shop_category_products_path(current_user, @shop, @category)
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

  def product_params
  	params.require(:product).permit(:name, :detail, :price, :avatar)
  end

  def check_role
    @role = Role.find_by_user_id(current_user.id)
    if(@role.name != "seller")
      redirect_to reusers_path
    end
  end
end
