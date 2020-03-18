class ArticlesController < ApplicationController

  before_action :set_article, only: [:edit, :update, :destroy, :show]
  # this will call the method set_article before running edit, update, destroy and show actions

  before_action :require_user, except: [:index, :show]
  # this will call the method require_user (which is a helper and can be found in the application_controller)
  # before executing all actions apart from index and show.
  # require_user will evaluate if the user is logged in before executing the methods.
  # If the user is not logged in it will display a message warning him that he/she can't perform that action
  # Please note that the order in which you create "before_action" methods matters.

  before_action :require_same_user, only: [:edit, :update, :destroy]
  # this method will prevent logged users to edit articles that do not belong to then
  # by manually entering the URL localhost:3000/article/1/edit
  # The require_same_user method can be found at the end of this controller.


  def index
    # fetches all articles from the DB into @articles

    # @articles = Article.all

    # I have commented the line above as we will use paginate

    @articles = Article.paginate(page: params[:page], per_page: 4)
    # this will limit the number of article per page at 4



  end # end index



  def new
    # action called to invoke a new article model
    # new_article_path
    # articles#new

    @article = Article.new

  end #end new



  def edit
    # action called when a article is edited
    # edit_article_path
    # articles#edit

    # Article.find was replaced by the method set_article
    # and the function before_action at the top of this page.
    # before_action :set_article, only: [:edit, :update, :destroy, :show]
    # This guarantees that the method set_article will run as soon as the edit, update, destroy and show actions are called

  end #end edit



  def create
    # action called when a new article is created
    # POST method
    # articles#create

    # creates a instance of article based on the parameters that were passed
    @article = Article.new(article_params)

    # attributes the article to a current logged in user
    # current_user is a helper method found in application_controller
    @article.user = current_user

    # if article from view is valid, save the article on the DB
    # otherwise renders the new article page
    if @article.save
      flash[:success] = "Article was successfully created"
      redirect_to article_path(@article)

    else
      render :new
    end

  end #end create



  def update
    # action called when to update an article
    # PATCH /articles/id
    # articles#update


    if @article.update(article_params)
      flash[:success] = "Article was successfully updated"
      redirect_to article_path(@article)
    else
      render 'edit'
    end

  end #end update


  def show

    # Article.find was replaced by the method set_article
    # and the function before_action at the top of this page.
    # before_action :set_article, only: [:edit, :update, :destroy, :show]
    # This guarantees that the method set_article will run as soon as the edit, update, destroy and show actions are called

  end #end show




  def destroy
    # action called to delete an article
    # DELETE /articles/id
    # articles#destroy

    @article.destroy

    flash[:danger] = "Article deleted"
    redirect_to articles_path

  end #end destroy


  def require_same_user

    # first it checks if current_user is the same user passed in the params.
    # If not, it flashes a message and redirect the user to the root_page

    if current_user != @article.user
      flash[:danger] = "This does not belong to you!"
      redirect_to root_path
    end

  end



  private

    def article_params
      params.require(:article).permit(:title, :description)
    end

    def set_article
      @article = Article.find(params[:id])
    end

  end