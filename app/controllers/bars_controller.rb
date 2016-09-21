class BarsController < ApplicationController
  def index
    @bars = Bar.all
  end

  def attend
    @bar = Bar.find(params[:bar_id])

    unless not_attended?
      @bar.users << current_user
    else
      @bar.users.delete(current_user.id)
    end

    @bar.update!(bar_params)
  end

  private
  def not_attended?
    @bar.users.include? current_user
  end

  def bar_params
    params.permit(:name, :description, :attendees)
  end
end
