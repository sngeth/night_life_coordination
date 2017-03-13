class BarsController < ApplicationController
  before_action :authenticate_user!, only: [:attend]

  def index
    @current_location = current_user&.location
    @bars = Bar.where(location: @current_location)
  end

  def search
    get_yelp_results
    current_user&.update(user_params)
    @current_location = location
    @bars = Bar.where(location: location)

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

  def location
    params[:location]
  end

  def get_yelp_results
    results = Yelp.client.search(location, { term: 'bars', limit: 10 })

    results.businesses.each do |bar|
      Bar.find_or_create_by(name: "#{bar.name}", location: bar.location.city)
    end
  end

  def not_attended?
    @bar.users.include? current_user
  end

  def bar_params
    params.permit(:name, :description, :bar_id)
  end

  def user_params
    params.permit(:location)
  end
end
