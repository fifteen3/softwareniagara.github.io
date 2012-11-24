class EventsController < ApplicationController
  def index
    @events = Event.all

    respond_to do |format|
      format.json { render json: @events, status: :ok }
      format.xml  { render xml: @events, status: :ok }
    end
  end
end