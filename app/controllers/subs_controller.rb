class SubsController < ApplicationController
  before_action :verify_moderator, only: [:edit, :update, :destroy]

  def index
    @subs = Sub.all
    render :index
  end

  def show
    set_current_sub
    render :show
  end

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = current_user.subs.new(sub_params)
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    render :edit
  end

  def update
    @sub = Sub.update(sub_params)
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def destroy
    @sub.destroy
    redirect_to subs_url
  end

  private
    def sub_params
      params.require(:sub).permit(:title, :description, :moderator_id)
    end

    def verify_moderator
      set_current_sub
      unless current_user.id == @sub.moderator_id
        redirect_to sub_url(@sub)
      end
    end

    def set_current_sub
      @sub = Sub.find(params[:id])
    end
end
