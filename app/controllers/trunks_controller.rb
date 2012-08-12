class TrunksController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_location
  before_filter :find_trunk, :only => [:show, :edit, :update, :destroy, :power, :sys_info]
  respond_to :html, :json

  # GET /trunks
  # GET /trunks.json
  def index
    @trunks = @location.trunks

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @trunks }
    end
  end

  # GET /trunks/1
  # GET /trunks/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @trunk }
    end
  end

  #
  ## GET /trunks/new
  ## GET /trunks/new.json
  def new
    @trunk = Trunk.new()

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @trunk }
      format.js { render :layout => false }
    end
  end

  # GET /trunks/1/edit
  def edit
    respond_to do |format|
      format.js { render :layout => false }
    end
  end

  # POST /trunks
  # POST /trunks.json
  def create
    @trunk = Trunk.new(params[:trunk])

    respond_to do |format|
      if @trunk.save
        format.html { redirect_to user_locations_path(current_user), notice: 'Trunk was successfully created.' }
        format.json { render json: @trunk, status: :created, location: @trunk }
      else
        format.html { render user_locations_path(current_user) }
        format.json { render json: @trunk.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /trunks/1
  # PUT /trunks/1.json
  def update
    respond_to do |format|
      if @trunk.update_attributes(params[:trunk])
        format.html { redirect_to user_locations_path(current_user), notice: 'Trunk was successfully updated.' }
        format.json { head :no_content }
        format.js {}
      else
        format.html { render action: "edit" }
        format.json { render json: @trunk.errors, status: :unprocessable_entity }
        format.js { render :partial => 'edit', :layout => false }
      end
    end
  end

  def power
    #TODO toggle column state for enabled/disabled trunk
    respond_with(@trunk) do |format|
      format.html {}
      format.js {}
    end
  end

  def sys_info
    respond_with(@trunk) do |format|
      format.html {}
      format.js {}
    end
  end

  # DELETE /trunks/1
  # DELETE /trunks/1.json
  def destroy
    @trunk.destroy

    respond_to do |format|
      format.html { redirect_to user_locations_path(current_user) }
      format.json { head :no_content }
      # format.js { }
    end
  end

  private
  def find_location
    @location = Location.find(params[:location_id])
  end

  def find_trunk
    @trunk = @location.trunks.find(params[:id])
  end
end
