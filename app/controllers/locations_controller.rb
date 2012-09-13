class LocationsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :json
  before_filter :find_user_location, :only => [:show, :edit, :update, :destroy]
  before_filter :get_locations, :only => [:index]

  # GET /locations
  # GET /locations.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @locations }
    end
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    @location_for_destroy = @location.channels.blank? || (@location ? @location.channels.on.blank? : false)
    @channels = @location.channels.includes(:sip).includes(:chan_prefix_groups => :prefix_group)

    respond_to do |format|
      format.html { render :layout => !request.xhr? }
      format.json { render json: @location }
    end
  end

  ## GET /locations/new
  ## GET /locations/new.json
  #def new
  #  @location = Location.new
  #
  #  respond_to do |format|
  #    format.html # new.html.erb
  #    format.json { render json: @location }
  #  end
  #end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = current_user.locations.build(params[:location])
    respond_to do |format|
      if @location.save
        get_locations
        # format.html { redirect_to user_locations_path(current_user) + "##{dom_id(@location)}", notice: 'Location was successfully created.' }
        format.html { render :index, notice: 'Location was successfully created.' }
        format.json { render json: @location, status: :created, location: @location }
      else
        format.html { redirect_to :back }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /locations/1
  # PUT /locations/1.json
  def update
    respond_to do |format|
      if @location.update_attributes(params[:location])
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  private
  def find_user_location
    @location = if current_user.has_admin?
      Location.find(params[:id])
    else
      current_user.locations.find(params[:id])
    end

  end

  def get_locations
   # @locations = current_user.has_admin? ? Location.order(:id).all : current_user.locations.order(:id)
    @locations = current_user.locations.order(:id)
  end
end
