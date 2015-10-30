class SessionsController < ApplicationController
  
  def create
  	puts 'hello we are inc reat sreasdjakdn'
  	user = User.find_by email: params[:user][:email]
  	puts user.id
	  if user
	    session[:user_id] = user.id
	    redirect_to "/lands/rivendell", :notice => "Logged in!"
	  else
	    flash[:error] = "Invalid email or password"
	    redirect_to "/users/login"
	  end
  end

  def destroy
  session[:user_id] = nil
  redirect_to root_url, :notice => "Logged out!"
end

def user_params
  	params.require(:user).permit(:email)
  end
end