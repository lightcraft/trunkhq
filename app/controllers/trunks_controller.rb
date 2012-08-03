class TrunksController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_location
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
    @trunk =  @location.trunks.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @trunk }
    end
  end
  #
  ## GET /trunks/new
  ## GET /trunks/new.json
  #def new
  #  @trunk = Trunk.new()
  #
  #  respond_to do |format|
  #    format.html # new.html.erb
  #    format.json { render json: @trunk }
  #  end
  #end

  # GET /trunks/1/edit
  def edit
    @trunk =  @location.trunks.find(params[:id])
  end

  # POST /trunks
  # POST /trunks.json
  def create
    @trunk = Trunk.new(params[:trunk])

    respond_to do |format|
      if @trunk.save
        format.html { redirect_to @trunk, notice: 'Trunk was successfully created.' }
        format.json { render json: @trunk, status: :created, location: @trunk }
      else
        format.html { render action: "new" }
        format.json { render json: @trunk.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /trunks/1
  # PUT /trunks/1.json
  def update
    @trunk =  @location.trunks.find(params[:id])

    respond_to do |format|
      if @trunk.update_attributes(params[:trunk])
        format.html { redirect_to @trunk, notice: 'Trunk was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @trunk.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trunks/1
  # DELETE /trunks/1.json
  def destroy
    @trunk =  @location.trunks.find(params[:id])
    @trunk.destroy

    respond_to do |format|
      format.html { redirect_to trunks_url }
      format.json { head :no_content }
    end
  end

  private
  def find_location
     @location = Location.find(params[:location_id])
  end
end
