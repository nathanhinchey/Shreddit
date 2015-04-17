class PostsController < ApplicationController
  before_action :verify_author, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all
    render :index
  end

  def show
    set_current_post
    render :show
  end

  def new
    @post = Post.new
    render :new
  end

  def create
    @post = current_user.posts.new(post_params)
    repopulate_postsubs

    if @post.sub_ids.empty?
      redirect_to new_sub_post(sub_id: params[:sub_id])
    end

    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    render :edit
  end

  def update
    @post = Post.update(post_params)
    repopulate_postsubs
    if @post.sub_ids.empty?
      @post.destroy
      redirect_to posts_url
    end

    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url
  end

  private
    def post_params
      params.require(:post).permit(:title, :url, :content, :sub_ids, :author_id)
    end

    def verify_author
      set_current_post
      unless current_user == @post.author
        redirect_to post_url(@post)
      end
    end

    def set_current_post
      @post = Post.find(params[:id])
    end

    def repopulate_postsubs
      @post.sub_ids = params[:post][:sub_ids]
    end
end
