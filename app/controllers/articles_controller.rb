class ArticlesController < ApplicationController

  before_action :set_article, only: [:edit, :update, :destroy, :show]

  def index
    @articles = Article.all

  end



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

    # if article from view is valid, save the article on the DB
    # otherwise renders the new article page
    if @article.save
      flash[:notice] = "Article was successfully created"
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
      flash[:notice] = "Article was successfully updated"
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

    flash[:notice] = "Article deleted"
    redirect_to articles_path

  end #end destroy



  private

    def article_params
      params.require(:article).permit(:title, :description)
    end

    def set_article
      @article = Article.find(params[:id])
    end

  end