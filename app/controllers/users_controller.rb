class UsersController < ApplicationController

  # this controller handles user sing-up, sing-in and log-off, as well as all validations
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save 
      sign_in @user
      flash[:success] = "You have succesfully created your account, Welcome to tKiero App !!!"
      redirect_to @user
      #redirect_to root_url, :notice => "Signup !!!"
    else
      render 'new'
    end
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
end
