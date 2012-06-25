class StaticPagesController < ApplicationController

  #Static Page of the site - HOME
  def home
    if signed_in?
         @user = current_user
    end
  end

  #Static Page of the site - HELP
  def help
  end

  #Static Page of the site - ABOUT
  def about
  end

  #Static Page of the site - ABOUT
  def contact
  end

end
