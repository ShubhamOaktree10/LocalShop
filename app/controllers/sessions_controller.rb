class SessionsController < ApplicationController
	def new
		@user = User.new
	end
  
	def create
		@user = User.find_by_email(params[:session][:email])
    if @user.status == true
				if @user && @user.authenticate(params[:session][:password])
						session[:user_id] = @user.id
						@role             = Role.find_by_user_id(@user.id)

						if(@role.name == "admin")
			        redirect_to admins_path
			      
			      elsif (@role.name == "seller")
			        redirect_to sellers_path
			      
			      elsif (@role.name == "buyer")
			        redirect_to buyers_path 
			      end				
				else
				  redirect_to '/login', alert:"inavalid Email Or Paasword"
				end
		else
			redirect_to '/login', alert:"U Are Blocked"
		end
	end

  def destroy
    session[:user_id] = nil
    redirect_to '/', alert:"Logout Succesfully"
  end
end
