class SessionsController < ApplicationController

  def new


  end


  def create

    # first we try to find a user based on the email
    # the was passed as a paramenter
    user = User.find_by(email: params[:session][:email].downcase)


    # then, if the user is found we try to authenticate using the given password
    # if the password matches, we then:
    #   *create a session with the user id, then
    #   * we display a message and
    #   * we send the user to the user profile page.
    # Otherwise, we display a message and render the same view again.
    if user && user.authenticate(params[:session][:password])

      session[:user_id] = user.id
      flash[:success] = "You have successfully logged in"
      redirect_to user_path(user)

    else

      flash.now[:danger] = "Email and password don't match"
      # flash.notice vs flash.now - flash.now won't persist

      render "new"


    end

  end


  def destroy

    # this method will set the session[:user_id] that we used
    # during the login phase, to nil.
    # Then it displays a message and redirects the user to the root path
    session[:user_id] = nil
    flash[:success] = "You have successfully logged out"
    redirect_to root_path

  end

end
