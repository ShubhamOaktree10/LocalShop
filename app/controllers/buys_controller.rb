class BuysController < ApplicationController
  def index
    @buys = Buy.where("user_id = ?", current_user.id)
  end
  def create
    @buy = Buy.new(buy_params)
    @quantity = Quantity.find_by_product_id(@buy.product_id)
    if @quantity == nil
      redirect_to showproduct_path(@buy.product_id), alert: "Product Not Available"
    else
      if @quantity.total > 0 && @quantity.total >= @buy.quant
        @quantity.total = @quantity.total - @buy.quant
          if @buy.save && @quantity.save
            
            redirect_to showproduct_path(@buy.product_id), alert: "Buy Succesfully"
          else
            redirect_to showproduct_path(@buy.product_id), alert: "Something Wrong"
          end
      else
        redirect_to showproduct_path(@buy.product_id), alert: "Out Of Stoke"
      end
    end
  end
	
  private 
  def buy_params
	  params.require(:buy).permit(:product_id, :user_id, :quant)
  end
end
