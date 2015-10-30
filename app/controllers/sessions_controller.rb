class SessionsController < ApplicationController
  
  def create
  	puts 'hello we are inc reat sreasdjakdn'
  	user = User.find_by email: params[:user][:email]
  	puts user.id

    if user
  	  if user.fitbit_token
  	    session[:user_id] = user.id
  	    redirect_to "/dashboards/index", :notice => "Logged in!"
  	  else
  	    redirect_to "/auth/fitbit"
  	  end
    else 
      flash[:error] = "Invalid email or password"
      redirect_to "/user/login"
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