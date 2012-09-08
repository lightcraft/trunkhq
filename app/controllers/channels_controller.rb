class ChannelsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_location
  before_filter :find_channel, :only => [:show, :edit, :update, :destroy, :power, :sys_info]
  before_filter :init_prefix_groups, :only => [:new, :create, :update, :edit]
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
    @channel.sip = Sip.new
    @prefix_groups = PrefixGroup.order(:group_name).all
    #groups = @prefix_groups.collect { |group| {
    #    name: group.group_name,
    #    call_min_interval: 60,
    #    calls_per_interval: 2,
    #    interval_mins: 60,
    #    prefix_group_id: group.id,
    #    max_minutes_per_day: group.def_minutes_per_day,
    #} }
    @channel.build_prefix_groups

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @channel }
      format.js { render :layout => false }
    end
  end

# GET /channels/1/edit
  def edit

    @channel.build_prefix_groups

    respond_to do |format|
      format.js { render :layout => false }
    end
  end

# POST /channels
# POST /channels.json
  def create
    @channel = Channel.new(params[:channel])
    @channel.sip.user = current_user
    @channel.valid?

    respond_to do |format|
      if @channel.save
        format.html { redirect_to user_locations_path(current_user), notice: 'Channel was successfully created.' }
        format.json { render json: @channel, status: :created, location: @channel }
        format.js { render :text => "window.location = '#{user_locations_path(current_user)}'", notice: 'Channel was successfully created.' }
      else
        format.html { render user_locations_path(current_user) }
        format.json { render json: @channel.errors, status: :unprocessable_entity }
        format.js { render action: "new", layout: false }
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
        format.js { render :text => "window.location = '#{user_locations_path(current_user)}'", notice: 'Channel was successfully updates.' }
      else
        format.html { render action: "edit" }
        format.json { render json: @channel.errors, status: :unprocessable_entity }
        format.js { render action: 'edit', layout: false }
      end
    end
  end

  def power
    @channel.state_on
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
    @location = Location.where(user_id: current_user).find(params[:location_id])
  end

  def find_channel
    @channel = @location.channels.find(params[:id])
  end

  def init_prefix_groups
    @prefix_groups = PrefixGroup.order(:group_name).all
  end

end
