class AdminsController < ApplicationController
  before_action :check_role
  def index
      if params["q"].present?
        @products = Product.where("name LIKE ?", "%#{params["q"]}%").paginate :page => params[:page], :per_page => 4
        @favorites = Favorite.where("user_id = ?", current_user.id)
      else
        @favorites = Favorite.where("user_id = ?", current_user.id)
        @products = Product.order(:name).paginate :page => params[:page], :per_page => 4
      end
  end 

  def allusers
    @roles = Role.all
  end
  
  def allshops
    @shops = Shop.all
  end

  def allcategories
    @categories = Category.all
  end

  def edit
    @admin = User.find(params[:id])
  end

  def show
    @admin = User.find(params[:id])
  end
  
  private

  def check_role
    if current_user != nil
      @role = Role.find_by_user_id(current_user.id)
      if(@role.name != "admin")
        redirect_to reusers_path
      end
    else
      redirect_to users_path
    end
  end

  def admin_params
    params.require(:admin).permit(:FirstName, :LastName, :email, :password, :address, :city, :state, :country, :pincode, :status)
  end

end
