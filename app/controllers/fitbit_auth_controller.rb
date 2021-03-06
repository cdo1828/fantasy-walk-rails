class FitbitAuthController < ApplicationController
	
  def get_response
    # Callback from Fitbit Oauth

    # Oauth Access Credentials
    oauth_token = params[:oauth_token]
    oauth_verifier = params[:oauth_verifier]

    # User Information and User Access Credentials
    @fitbit_data  = request.env['omniauth.auth']

    user = User.find(session[:user_id])
    user.update(full_name:@fitbit_data["info"]["display_name"], fitbit_uid:@fitbit_data["uid"], fitbit_token:@fitbit_data["credentials"]["token"], fitbit_secret:@fitbit_data["credentials"]["secret"])
    # Get User Activity Information
    # activities = get_user_activities(fitbit_data)
    # user = get_user_info(fitbit_data)
    total_distance = get_user_distance(@fitbit_data)
    @distance = total_distance
    puts "HERE IS THE DISTANCE:", @distance
    # puts "HERE IS MOAR:", @distance.activities-tracker-distance


    @fitbit_data[:token] = oauth_token = params[:oauth_token]
    @fitbit_data[:verifier] = oauth_token = params[:oauth_verifier]
    
    # session[:distance] = @distance
    # render json:activities
    # render json:user
    # render json:fitbit_data
    # render json:@distance
    # redirect_to '/dashboards/index'

    # session[:fitbit] = @fitbit_data
    # render json:activities
    # render json:user
    # render json:@fitbit_data
    # render json:@fitbit_data
    render '/dashboards/index'
  end

private
  def get_user_activities(fitbit_data)
    fitbit_user_id = fitbit_data["uid"]
    user_secret = fitbit_data["credentials"]["secret"]
    user_token = fitbit_data["credentials"]["token"]

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

    # client.activities_on_date('2015-03-25') <- Specific Date
    client.activities_on_date('today')
    # client.activity_statistics
  end

  def get_user_info(fitbit_data)
    fitbit_user_id = fitbit_data["uid"]
    user_secret = fitbit_data["credentials"]["secret"]
    user_token = fitbit_data["credentials"]["token"]

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

    client.user_info
  end

  def get_user_distance(fitbit_data)
    fitbit_user_id = fitbit_data["uid"]
    user_secret = fitbit_data["credentials"]["secret"]
    user_token = fitbit_data["credentials"]["token"]

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

    client.data_by_time_range('/activities/tracker/distance',{:base_date => '2015-10-21', :end_date => 'today'})
  end
end
