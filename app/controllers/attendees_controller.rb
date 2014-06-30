class AttendeesController < ApplicationController
  before_action :set_attendee, only: [:show, :edit, :destroy, :update]
  before_action :require_logged_in, only: [:create, :destroy]

  # GET /attendees
  # GET /attendees.json
  def index
    @attendees = Attendee.all
  end

  # GET /attendees/1
  # GET /attendees/1.json
  def show
  end

  # GET /attendees/new
  def new
    @attendee = Attendee.new
  end

  # GET /attendees/1/edit
  def edit
  end

  # POST /attendees
  # POST /attendees.json
  def create

    unless check_attending

      # raise StandardError
    

      @attendee = Attendee.new(attendee_params)
      
      @attendee.user = current_user

      respond_to do |format|
        if @attendee.save
          format.html { redirect_to :back }
          format.json { render :show, status: :created, location: @attendee }
        else
          format.html { render :new }
          format.json { render json: @attendee.errors, status: :unprocessable_entity }
        end
      end
     else
      redirect_to :back, notice: 'Already signed up'
      # flash[:notice] = 
    end 
  end

 

  # PATCH/PUT /attendees/1
  # PATCH/PUT /attendees/1.json
  def update
    respond_to do |format|
      if @attendee.update(attendee_params)
        format.html { redirect_to @attendee, notice: 'Attendee was successfully updated.' }
        format.json { render :show, status: :ok, location: @attendee }
      else
        format.html { render :edit }
        format.json { render json: @attendee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attendees/1
  # DELETE /attendees/1.json
  def destroy
    
    @attendee.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Attendee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attendee
      @attendee = Attendee.find(params[:id])
    end

    # def set_destroy_attendee
    #   @attendee = Attendee.where("user_id = 16 AND event_id = 1")

    # end 

    # Never trust parameters from the scary internet, only allow the white list through.
    def attendee_params
      params.require(:attendee).permit(:event_id)
    end

     def check_attending 

     @event = Event.find(attendee_params[:event_id])

     attendees = @event.attendees.map {|attendee| attendee.user_id} 

     attendees.include?(current_user.id)

  end 

end
