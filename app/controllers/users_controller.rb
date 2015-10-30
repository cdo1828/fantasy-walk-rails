class UsersController < ApplicationController
	
  def create
  	@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			
			redirect_to '/users/login'
		else
			flash[:errors] = @user.errors.full_messages
			redirect_to '/register'
		end
  end

  def register
  	
  end

  def login

  end

  def user_params
  	params.require(:user).permit(:user_email, :user_password)
  end

end