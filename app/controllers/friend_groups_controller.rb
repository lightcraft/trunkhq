class FriendGroupsController < ApplicationController
  respond_to :html, :json, :js

  before_filter :authenticate_user!
  before_filter { redirect_to root_path unless current_user.can_add_friendgroups? }
  before_filter :find_group, :only => [:show, :edit, :update, :destroy]

  def index
    @friend_groups = current_user.friend_groups.page(params[:page]).per(10)

    respond_to do |format|
      format.html
      format.json { render json: @prefix_groups }
    end
  end

  def new
    @friend_group = FriendGroup.new

    respond_to do |format|
      format.html
      format.json { render json: @friend_group }
      format.js { render :layout => false }
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.js { render layout: false }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @friend_group }
    end
  end

  def create
    @friend_group = current_user.friend_groups.build(params[:friend_group])

    respond_with(@friend_group, :location => user_friend_groups_path) do |format|
      if @friend_group.save
        format.html { redirect_to @friend_group, notice: 'Friend Group was successfully created.' }
        format.json { render json: @friend_group, status: :created, location: @friend_group }
        format.js { render :text => "window.location = '#{user_friend_groups_path}'", notice: 'Friend Group was successfully created.' }
      else
        format.html { render action: "new" }
        format.json { render json: @friend_group.errors, status: :unprocessable_entity }
        format.js { render action: "new", layout: false }
      end
    end
  end

  def update
    respond_to do |format|
      if @friend_group.update_attributes(params[:friend_group])
        format.html { redirect_to user_friend_groups_path, notice: 'Prefix group was successfully updated.' }
        format.json { head :no_content }
        format.js { render :text => "window.location = '#{user_friend_groups_path}'", notice: 'Prefix Group was successfully updated.' }
      else
        format.html { render action: "edit" }
        format.json { render json: @friend_group.errors, status: :unprocessable_entity }
        format.js { render action: "edit", layout: false }
      end
    end
  end

  def destroy
    @friend_group.destroy

    respond_to do |format|
      format.html { redirect_to user_friend_groups_url }
      format.json { head :no_content }
      format.js { render :text => "$('##{dom_id(@friend_group)}').remove();" }
    end
  end

  def channels_assignment
    @channels = current_user.channels
    @channels = @channels.where(:location_id => params[:location_id] ) if params[:location_id]
    @friend_groups = current_user.friend_groups
  end

  def assign_channels
    channels = current_user.channels.find_all_by_id(params[:channel_ids])

    if channels.present?
      friend_group = current_user.friend_groups.find_by_id(params[:friend_group_id])

      if friend_group
        channels.each { |channel| channel.update_attribute(:friend_group, friend_group) }
      else
        channels.each { |channel| channel.update_attribute(:friend_group, nil) }
      end
    end

    redirect_to channels_assignment_user_friend_groups_path
  end

  private

  def find_group
    @friend_group = current_user.friend_groups.find(params[:id])
  end
end
