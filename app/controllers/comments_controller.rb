class CommentsController < ApplicationController
  before_action :validate_author, only: [:edit, :update, :destroy]

  def new
    @comment = Comment.new
    render :new
  end

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = params[:post_id]
    if @comment.save
      redirect_to post_url(id: @comment.post_id)
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    render :edit
  end

  def update
    @comment = Comment.update(comment_params)
    if comment.save
      redirect_to post_url(id: @comment.post_id)
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to post_url(id: @comment.post_id)
  end

  private

    def comment_params
      params.require(:comment).permit(:author_id, :post_id, :content)
    end

    def validate_author
      author_id = Comment.find(params[:id]).author_id
      unless current_user.id == author_id
        redirect_to :forbidden
      end
    end

end
