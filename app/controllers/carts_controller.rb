class CartsController < ApplicationController
	
  before_action :set_product, only: [:create]
  def index
  	@carts = Cart.where("user_id = ?", current_user)
  end
  def create
    @quantity = Quantity.find_by("product_id = ?", @product.id)
    if  (@quantity == nil)
        redirect_to showproduct_path(@product.id), alert: "Product Not Available"
    else
    	@cart = Cart.create(cart_params)      	      
      respond_to do |format|
        format.html { redirect_to showproduct_path(@cart.product_id), alert: "Add Successfully" }
        format.json { head :no_content }
        format.js   { render :layout => false }
      end
    end
  end

  def destroy
  	@cart = Cart.find(params[:id])
  	@cart.destroy
    respond_to do |format|
      format.html { redirect_to carts_path, alert: "Removed From Carts" }
      format.json { head :no_content }
      format.js   { render :layout => false }
    end
  	
  end
  
  private
  def set_product
    cart = Cart.new(cart_params)
    @product = Product.find(cart.product_id)
  end
  
  def cart_params
    params.require(:cart).permit(:product_id, :user_id)
  end
end
