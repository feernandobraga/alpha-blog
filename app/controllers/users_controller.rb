class UsersController < ApplicationController

  before_action :set_user, only: [:edit, :update, :show]
  # this method will call the method set_user before executing
  # edit, update and show.
  # The method set_user gets the user based on an ID passed through the parameters


  before_action :require_same_user, only: [:edit, :update]
  # this method will prevent logged users to edit other users
  # buy manually entering the URL localhost:3000/users/1/edit
  # The require_same_user method can be found at the end of this controller.

  def index
    @users = User.paginate(page: params[:page], per_page: 2)
    # this will implement pagination to the view that displays all users
    # and it will limit it to two users per page
  end


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


  def edit

    # the method set_user will run because of the method before_action
    # at the top of this page. This will grab a user based on a user id
    # passed as a parameter

  end


  def update

    # this code will run after the user press the Update button when editing a user.
    # It creates an instance variable @user and populates the model with the information
    # coming from the parameters.
    # Then, if the update was successfully, it flashes a notice and display all article,
    # otherwise it renders the same page again.

    # the method set_user will run because of the method before_action
    # at the top of this page. This will grab a user based on a user id
    # passed as a parameter

    if @user.update(user_params)

      flash[:success] = "Your account was updated successfully"
      redirect_to articles_path

    else

      render "edit"

    end

  end # end update


  def show

    # the method set_user will run because of the method before_action
    # at the top of this page. This will grab a user based on a user id
    # passed as a parameter

    # if we implement the pagination to @user, it won't work because
    # this method only displays one user per time.
    # Therefore, we need to create a new instance variable
    # called @user_articles that we will handle the pagination for us

    @user_articles = @user.articles.paginate(page: params[:page], per_page: 3)
    # this piece of code will apply pagination to all articles from a given user
    # and limit it to 3 articles per page

  end


  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end


  def set_user

    # the method set_user runs before the methods edit, update and show
    # and all it does is it creates an instance variable @user
    # by retrieving from the database a user based on a given user id
    # that was passed as a parameter.

    @user = User.find(params[:id])
  end

  def require_same_user

    # this method will prevent logged users to edit other users
    # by manually entering the URL localhost:3000/users/X/edit, where X is any user id



    if current_user != @user
      flash[:danger] = "Nice try buddy"
      redirect_to root_path

    end

  end

end
