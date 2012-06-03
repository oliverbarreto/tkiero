module SessionsHelper

  #Writes user remember_token on user's lcoal cookie
  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    current_user = user
    #Using cookies.permanent causes Rails to set the expiration to 20.years.from_now automatically.
  end
  
  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

end
