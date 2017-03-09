class BarsController < ApplicationController
  def index
    @bars = Bar.all
  end

  def search
    @results = Yelp.client.search(params[:q], { term: 'bars', limit: 10 })

    respond_to do |format|
      format.html { render :index }
      format.json { render json: @results }
    end
  end

  def attend
    @bar = Bar.find(params[:bar_id])

    unless not_attended?
      @bar.users << current_user
    else
      @bar.users.delete(current_user.id)
    end

    @bar.update!(bar_params)

    render nothing: true
  end

  private
  def not_attended?
    @bar.users.include? current_user
  end

  def bar_params
    params.permit(:name, :description, :attendees)
  end
end
