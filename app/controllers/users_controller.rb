class UsersController < ApplicationController
  def index
    if params["q"].present?
      @products = Product.where("name LIKE ?", "%#{params["q"]}%").paginate :page => params[:page], :per_page => 4
    else
      @products = Product.order(:name).paginate :page => params[:page], :per_page => 4
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def showproduct
    if (current_user != nil)
      @product = Product.find(params[:format])
      @carts = Cart.where("user_id = ?", current_user.id)
      @ratings = Rating.where("user_id = ?", current_user.id)
    else
      redirect_to users_path
    end
  end

  def new
    @user = User.new
    @role = Role.new
  end

  def search
    @product = Product.find_by_name(params["q"])
  end  

  def create
    @user = User.new(user_params)
    @role = Role.new(role_params)
    if @user.save && @role.save
      session[:user_id] = @user.id
      @role.user_id = @user.id
      @role.save
        if(@role.name == "admin")
          redirect_to admins_path
        elsif (@role.name == "seller")
          redirect_to sellers_path
        else
          redirect_to buyers_path 
        end
    else 
      redirect_to '/signup'
    end 
  end 

  def edit
    @user = User.find(params[:id])
    @role = Role.find_by_user_id(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      if (current_user.id == @user.id)
        redirect_to current_user
      else
        redirect_to allusers_path(:q => @user.id)
      end
    else
      render :edit
    end
  end

  def reusers
    @role = Role.find_by_user_id(current_user.id)
    if @role.name == "admin"      
      redirect_to admins_path
    elsif @role.name == "seller"      
       redirect_to sellers_path
    else
      redirect_to buyers_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:FirstName, :LastName, :email, :password, :address, :city, :state, :country, :pincode, :status)
  end

  def role_params
    params.require(:user).permit(:name)
  end
end
