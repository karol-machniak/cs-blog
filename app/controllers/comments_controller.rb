class CommentsController < ApplicationController
  
  before_action :load_article
#/ GET /articles/:article_id/comments
  def create
    if params[:picture_id].present?
      @picture = @article.pictures.find(params[:picture_id])
    end 

    @comment = (@picture || @article).comments.new(comment_params)
   
    if @comment.save
      flash[:success] = t('comments.create.success')
      if @picture.present?
        redirect_to article_picture_path(@article.id, @picture.id)
      else
        redirect_to article_path(@article.id)
      end
    else
      flash.now[:error] = t(
        'comments.create.error', 
        problems: @article.errors.full_messages.to_sentence
        )
      if @picture.present?
        render 'pictures/show'
      else
        render 'article/show'
      end      
    end
  end

  def update
  end

  def destroy
  end


  private

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end

  def load_article
    @article = Article.find(params[:article_id])
  end


end
