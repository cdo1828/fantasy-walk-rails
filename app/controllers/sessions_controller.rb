class SessionsController < ApplicationController
  
  def create
  	puts 'hello we are inc reat sreasdjakdn'
  	user = User.find_by email: params[:user][:email]
  	puts user.id

    if user
  	  if user.fitbit_token

  	    session[:user_id] = user.id
        @fitbit_data = User.find(session[:user_id])
        total_distance = get_user_distance(@fitbit_data)
        @distance = total_distance
        # render json:@distance
        # puts @distance
        flash[:notice] = "Logged in!"
  	    render "/dashboards/index"

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
  flash[:notice] = "Logged out!"
  redirect_to root_url 
end


  private 

def get_user_distance(fitbit_data)
    fitbit_user_id = fitbit_data["fitbit_uid"]
    user_secret = fitbit_data["fitbit_secret"]
    user_token = fitbit_data["fitbit_token"]

    # Store this information in you user model for
    # logins in the future.
    client = Fitgem::Client.new({
      consumer_key: ENV['FITBIT_CLIENT_KEY'],
      consumer_secret: ENV['FITBIT_CLIENT_SECRET'],
      token: user_token,
      secret: user_secret,
      user_id: fitbit_user_id,
    })

    # Reconnects existing user using the information above
    access_token = client.reconnect(user_token, user_secret)

    # get user information with fitgem

        ##get date they started their journey
        # start_date = fitbit_data['created_at']

    client = [
      client.data_by_time_range('/activities/tracker/steps',{:base_date => '2015-10-21', :end_date => 'today'}),
      client.data_by_time_range('/activities/tracker/distance',{:base_date => '2015-10-21', :end_date => 'today'}),
      client.data_by_time_range('/activities/tracker/elevation',{:base_date => '2015-10-21', :end_date => 'today'}),
      client.data_by_time_range('/activities/tracker/calories',{:base_date => '2015-10-21', :end_date => 'today'}),
      client.data_by_time_range('/sleep/minutesAsleep',{:base_date => '2015-10-21', :end_date => 'today'})
    ]

    client

  end
end