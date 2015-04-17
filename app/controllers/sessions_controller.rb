class SessionsController < ApplicationController
  def create
    user = User.find_by_credentials(
      params[:user][:collar],
      params[:user][:password]
    )

    if user.nil?
      render :new
    else
      log_in_user!(user)
      redirect_to user_url(user)
    end
  end

  def new
    render :new
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil

    redirect_to new_session_url #TODO: change this
  end
end
