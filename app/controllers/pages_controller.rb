class PagesController < ApplicationController

  def home

    redirect_to articles_path if logged_in?
    # if the user is logged_in, he/she will be redirected to all articles page
    # The method logged_in? is a helper and can be found in the application_controller
    # It basically checks for an available session with the user ID

  end

  def about

  end


end