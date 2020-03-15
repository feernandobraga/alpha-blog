class UsersController < ApplicationController

  def new

    @user = User.new


  end





  def create

    # this method will run when the user press Sign up from the sign up page.
    # It creates an instance variable @user and populates the model with the information
    # coming from the parameters.


    @user = User.new(user_params)


    # if the user saves successfully, it will flash a message and redirect to the index of articles
    # but if not, it will re-render the same page

    if @user.save

      flash[:success] = "Welcome to the Alpha Blog #{@user.username}"
      redirect_to articles_path

    else
      render "new"
    end

  end # end create



  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end



end
