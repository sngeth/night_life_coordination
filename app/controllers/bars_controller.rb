class BarsController < ApplicationController
  before_action :authenticate_user!, only: [:attend]

  def index
    @bars = Bar.all
  end

  def search
    @results = Yelp.client.search(params[:q], { term: 'bars', limit: 10 })

    @results.businesses.each do |bar|
      Bar.find_or_create_by(name: "#{bar.name}")
    end

    @bars = Bar.all

    respond_to do |format|
      format.html { render :index }
      format.json { render json: @bars }
    end
  end

  def attend
    @bar = Bar.find(params[:bar_id])

    unless not_attended?
      @bar.users << current_user
    else
      @bar.users.delete(current_user.id)
    end

    respond_to do |format|
      format.js { render 'bars/attend' }
    end
  end

  private

  def not_attended?
    @bar.users.include? current_user
  end

  def bar_params
    params.permit(:name, :description, :bar_id)
  end
end
