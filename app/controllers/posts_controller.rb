class PostsController < ApplicationController
  before_action :set_post, only: %i[show destroy fork]

  def index
    @posts = paginate Post.includes(:forked_from).order(created_at: :desc)
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.order(created_at: :asc)
  end

  def destroy
    @post.destroy
    redirect_to posts_url, flash: { success: t('post.destroyed') }
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post, flash: { success: t('post.created') }
    else
      render :new, flash: { danger: t('post.creation_failed') }
    end
  end

  def new
    @post = Post.new
  end

  def fork
    forked = @post
    @post = @post.dup
    @post.forked_from = forked
    render :new
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:snippet, :title, :name, :forked_from_id)
  end
end
