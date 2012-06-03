class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      # Redirect to the root page
      #redirect_to root_url, :notice => "Logged In, Welcome to tKiero App !!!"
      
      # Redirect to the user Wall page page when loged in
      redirect_to user, :notice => "Logged In, Welcome to tKiero App !!!"
    else
      flash.now.alert = "Invalid eMail or Password"
      render "new"
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged Out !!!"
  end
  
end
