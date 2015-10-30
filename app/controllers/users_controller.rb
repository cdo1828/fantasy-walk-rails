class UsersController < ApplicationController
	skip_before_filter :verify_authenticity_token
  def create
  	@user = User.new(email:params[:email], password:params[:password])
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

end