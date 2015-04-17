class PostSubsController < ApplicationController
  before_action :verify_moderator, only: [:destroy]

  def create
  end

  def destroy
  end

  private

    def verify_moderator
      set_current_sub
      unless current_user.id == @sub.moderator_id
        redirect_to sub_url(@sub)
      end
    end

end
