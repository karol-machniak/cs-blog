class PicturesController < ApplicationController
  def index
    @article = Article.find(params[:article_id])
    authorize! = @article.pictures.accessible_by(current_ability, :index)
  end

  def new
    @article = Article.find(params[:article_id])
    @pictures = @article.pictures.new
    authorize! :new, @picture
  end

  def create
    @article = Article.find(params[:article_id])
    @pictures = @article.pictures.new(picture_params)
    authorize! :create, @picture
  end

  def update
  end

  def show
  end

  def destroy
  end

  private

  def picture_params
    params.require(:picture).permit(:title, :descripion, :image)


end