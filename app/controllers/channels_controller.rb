class ChannelsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_location
  before_filter :find_channel, :only => [:show, :edit, :update, :destroy, :power, :sys_info]
  respond_to :html, :json

  # GET /channels
  # GET /channels.json
  def index
    @channels = @location.channels

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @channels }
    end
  end

  # GET /channels/1
  # GET /channels/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @channel }
    end
  end

  #
  ## GET /channels/new
  ## GET /channels/new.json
  def new
    @channel = Channel.new()

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @channel }
      format.js { render :layout => false }
    end
  end

  # GET /channels/1/edit
  def edit
    respond_to do |format|
      format.js { render :layout => false }
    end
  end

  # POST /channels
  # POST /channels.json
  def create
    @channel = Channel.new(params[:channel])

    respond_to do |format|
      if @channel.save
        format.html { redirect_to user_locations_path(current_user), notice: 'Channel was successfully created.' }
        format.json { render json: @channel, status: :created, location: @channel }
      else
        format.html { render user_locations_path(current_user) }
        format.json { render json: @channel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /channels/1
  # PUT /channels/1.json
  def update
    respond_to do |format|
      if @channel.update_attributes(params[:channel])
        format.html { redirect_to user_locations_path(current_user), notice: 'Channel was successfully updated.' }
        format.json { head :no_content }
        format.js {}
      else
        format.html { render action: "edit" }
        format.json { render json: @channel.errors, status: :unprocessable_entity }
        format.js { render :partial => 'edit', :layout => false }
      end
    end
  end

  def power
    #TODO toggle column state for enabled/disabled channel
    respond_with(@channel) do |format|
      format.html {}
      format.js {}
    end
  end

  def sys_info
    respond_with(@channel) do |format|
      format.html {}
      format.js {}
    end
  end

  # DELETE /channels/1
  # DELETE /channels/1.json
  def destroy
    @channel.destroy

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

  def find_channel
    @channel = @location.channels.find(params[:id])
  end
end
