class ArticlesController < ApplicationController
  def new
    @article = Article.new
    render #opcjonalne, jeśli widok nie ma nazwy
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:success] = t('articles.create.success')
      redirect_to article_path(@article.id) #'/articles/#{articles}'
    else
      flash.now[:error] = t('article.create.error', problems: @article.errors.full_messages.to_sentence)
    end
  end

  def index
    @articles = Article.all
    render

  end

  def show
    @article = Article.find(params[:id])

  end

  def edit 
    @article = Article.find(params[:id])

  end
  
  def update 
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to article_path(@article.id)
    else
      render 'edit' #TODO poinformować co się udało
    end
  end


  def destroy
    article = Article.find(params[:id])
    article.destroy
    redirect_to articles_path
  end


  private

  def article_params
    params.require(:article).permit(:title, :text)
  end
end
