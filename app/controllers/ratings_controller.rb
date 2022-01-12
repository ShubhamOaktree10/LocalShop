class RatingsController < ApplicationController
  def create
    @rating = Rating.new(rating_params)
    if @rating.point != nil
      @rating.save
      redirect_to showproduct_path(@rating.product_id), alert: "Rating Success"
    else
      redirect_to showproduct_path(@rating.product_id), alert: "Give Rating Betwwen 1 To 5 "
    end
  end

  def update
    @rating = Rating.find(params[:id])
    @rating.update(rating_params)
    redirect_to showproduct_path(@rating.product_id)
  end
  
  private 
  def rating_params
    params.require(:rating).permit(:product_id, :user_id, :point, :Description)
  end
end
