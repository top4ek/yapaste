class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @post = Post.find(@comment.post_id)

    if @comment.save
      message = { success: t('comment.created') }
    else
      message = { danger: t('comment.validation.message') }
    end
    redirect_to @post, flash: message
  end

  private

  def comment_params
    params.require(:comment).permit(:post_id, :message)
  end
end
