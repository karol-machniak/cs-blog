class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]


  def new
    @article = Article.new
    render #opcjonalne, jeśli widok nie ma nazwy
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    authorize! :create, @article
    if @article.save
      flash[:success] = t('articles.create.success')
      redirect_to article_path(@article.id) #'/articles/#{articles}'
    else
      flash.now[:error] = t('article.create.error', problems: @article.errors.full_messages.to_sentence)
      render 'new'
    end
  end

  def index
    @authorize
    @articles = Article.all.accessible_by(current_ability, :index)
    render

  end

  def show

    @article = Article.find(params[:id])
    @comment = @article.comments.new
  end

  def edit 
    @article = Article.find(params[:id])
    authorize! :edit, @article

  end
  
  def update 
    @article = Article.find(params[:id])
    authorize! :update, @article
    if @article.update(article_params)
      redirect_to article_path(@article.id)
    else
      render 'edit' #TODO poinformować co się udało
    end
  end


  def destroy
    article = Article.find(params[:id])
    authorize! :destroy, article
    article.destroy
    redirect_to articles_path
  end


  private

  def article_params
    params.require(:article).permit(:title, :text, :terms_of_service)
  end
end
