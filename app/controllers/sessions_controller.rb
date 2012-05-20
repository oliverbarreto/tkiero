class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to root_url, :notice => "Logged In !!!"
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
