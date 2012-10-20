class Admin::EventsController < Admin::ApplicationController
  before_filter :get_events, only: [:index]
  before_filter :get_event, except: [:index, :new, :create]

  def index
    respond_to do |format|
      format.html
      format.json { render json: @events, status: :ok }
      format.xml { render xml: EventbriteConsumer.new({app_key: API_PROVIDERS['eventbrite']['app_key'],user_key: API_PROVIDERS['eventbrite']['user_key']}).fetch, status: :ok }
    end
  end

  def new
    @event = Event.new

    respond_to do |format|
      format.html
    end
  end

  def create
    @event = Event.new(params[:event])
    @event.user_id = current_user.id if defined? current_user

    respond_to do |format|
      if @event.save
        format.html { redirect_to edit_admin_event_path(@event), notice: 'Created event.' }
        format.json { render json: @event, status: :created }
        format.xml { render xml: @event, status: :created }
      else
        format.html { render 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
        format.xml { render xml: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    respond_to do |format|
      format.html
    end
  end

  def update
    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to edit_admin_event_path(@event), notice: 'Updated event.' }
        format.json { render json: @event, status: :ok }
        format.xml { render xml: @event, status: :ok }
      else
        format.html { render 'edit' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
        format.xml { render xml: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event.destroy

    respond_to do |format|
      format.html { redirect_to admin_events_path, notice: 'Event deleted.' }
      format.json { render json: @event, status: :deleted }
      format.xml { render xml: @event, status: :deleted }
    end
  end

  private

  def get_events
    @events = Event.all || []
  end

  def get_event
    @event = Event.find(params[:id]) || nil
  end
end