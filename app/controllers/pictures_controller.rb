class PicturesController < ApplicationController
  def index
    @article = Article.find(params[:article_id])
    authorize! :index, @article 
    @pictures = @article.pictures.accessible_by(current_ability, :index)
  end

  def new
    @article = Article.find(params[:article_id])
    @picture = @article.pictures.new
    authorize! :new, @picture
  end

  def create
    @article = Article.find(params[:article_id])
    @picture = @article.pictures.new(picture_params)
    authorize! :create, @picture
    @picture.save!
    redirect_to article_pictures_path(@article)
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


end