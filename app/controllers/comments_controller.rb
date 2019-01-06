class CommentsController < ApplicationController
  before_action :load_article
#/ GET /articles/:article_id/comments
  def create
    @comment = @article.comments.new(comment_params)
    if @comment.save
      flash[:success] = t('comments.create.success')
      redirect_to article_path(@article.id)
    else
      flash.now[:error] = t(
        'comments.create.error', 
        problems: @article.errors.full_messages.to_sentence
        )
        render 'articles/show'
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
