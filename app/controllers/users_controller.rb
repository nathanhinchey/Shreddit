class UsersController < ApplicationController

  def index
    @users = User.all
    render :index
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_url
  end

  def edit
    @user = User.find(params[:id])
    render :edit
  end

  def update
    @user = User.new(user_params)
    if @user.save
      redirect_to user_url(@user)
    else
      flash.now[:error] = @user.errors.full_messages
      render :edit
    end
  end

  private

    def user_params
      params.require(:user).permit(:collar, :password)
    end

end
