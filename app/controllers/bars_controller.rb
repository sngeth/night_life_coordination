class BarsController < ApplicationController
  def index
    @bars = Bar.all
  end

  def attend
    bar = Bar.find(params[:bar_id])
    bar.attendees += 1
    bar.update!(bar_params)

    render nothing: true
  end


  private
  def bar_params
    params.permit(:name, :description, :attendees)
  end
end
