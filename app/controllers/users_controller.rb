class UsersController < ApplicationController

  def new
    @user = User.new
  end
	
  puts "users controller"
  def create
  	@user = User.new(user_params)
    puts "putting user:", @user
		if @user.save
			session[:user_id] = @user.id
			
      # redirect_to 'auth/fitbit'
			redirect_to '/lands/rivendell'
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
  	params.require(:user).permit(:email, :password)
  end

end