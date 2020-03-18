class ApplicationController < ActionController::Base

  # this controller contains some helper methods.
  # All methods here are available to all controller, BUT NOT to the views!
  # To make specific methods available to the views we
  # need to user the method help_method and pass in the methods that
  # we want available to the views.

  helper_method :current_user, :logged_in?

  def current_user


    @current_user ||= User.find(session[:user_id]) if session[:user_id]

    # return the user if there's a session with a user id
    # BUT ONLY if @current_user is null.
    # This prevents ruby from asking for the information on the database all the time.
    # The symbol ||= means that the second part of the command is only executed if the
    # first part is nil

  end



  def logged_in?

    # this method will check if the method current_user is true (if it returned a user)
    # and then, will convert it to a BOOLEAN if
    # To convert anything to a boolean we use (!!) the double exclamation marks

    !!current_user

  end


  def require_user

    # this method will alert the user that he/she must be logged in to perform
    # certain actions, and then redirect the user to the root_path

    if !logged_in?

      flash[:danger] = "You must be logged in to perform this action"
      redirect_to root_path

    end


  end


end
