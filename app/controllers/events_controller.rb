class EventsController < ApplicationController
  before_action :set_event, only: [:edit, :update, :destroy ]
  before_action :show_events_helper, only: [:show]
  before_action :require_logged_in, only: [:index, :new, :create, :edit, :update, :destroy]
  before_action :restrict_to_current_user, only: [:edit, :update, :destroy]
  

  # GET /events
  # GET /events.json

  # def index
    # @events = Event.all
    # @events = current_user.events.all
  # end

  # GET /events/1
  # GET /events/1.json
  def show

    id_for_event_owner = @event.user_id
    @event_owner = User.find(id_for_event_owner)

    #find all of the attendee objects for an event 
    attendee_objects = @event.attendees

    #extract their ids into an array 

    attendee_object_ids = attendee_objects.map {|object| object.user_id}

    #get rid of the id for the owner of the event, so they are duplicated in _list_attendees

    attendee_object_ids.delete(id_for_event_owner) 

    #find all the non-owner attendees of an event 

    @attendees = User.find(attendee_object_ids)

    #variables for distance_of_time_in_words method 
    # @from_time = Time.now 

    
  end

  # GET /events/new
  def new
    # @event = Event.new
    @event = current_user.events.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = current_user.events.new(event_params)
    # @event = Event.new(event_params)
 

    respond_to do |format|
      if @event.save
        #add the creator of an event as an attendee

        @attendee = @event.attendees.create(user_id: current_user.id)
        # raise StandardError
        format.html { redirect_to user_path(@event.user), notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }

      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def join 
    #define which @event
    @attendee = @event.attendees.create(user_id: current_user.id)
    redirect_to user_path(@event.user)
    



  end 


  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_event_to_join 
      
    #   @event = Event.find(params[:id])

    # end 

    def set_event
      @event = current_user.events.find(params[:id])
    end

    def show_events_helper 
      @event = Event.find(params[:id])


    end 

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:description, :location, :date, :time, :user_id, :datetime, :category, :zip_code, :street_address, :neighborhood)
      # params[:event]
    end
end
