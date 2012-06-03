module SessionsHelper
  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    current_user = user
    #Using cookies.permanent causes Rails to set the expiration to 20.years.from_now automatically.
  end

end
