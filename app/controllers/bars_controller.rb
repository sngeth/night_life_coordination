class BarsController < ApplicationController
  def index
    @bars = Bar.all
  end

  def attend
    @bar = Bar.find(params[:bar_id])
    @bar.users << current_user unless not_attended?
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
