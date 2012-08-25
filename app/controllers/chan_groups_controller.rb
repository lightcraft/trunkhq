class ChanGroupsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_group, :only => [:show, :edit, :update, :destroy]
  respond_to :html, :json, :js

  # GET /chan_groups
  # GET /chan_groups.json
  def index
    @chan_groups = ChanGroup.order(:chan_group_name).page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @chan_groups }
    end
  end

  # GET /chan_groups/1
  # GET /chan_groups/1.json
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @chan_group }
    end
  end

  # GET /chan_groups/new
  # GET /chan_groups/new.json
  def new
    @chan_group = ChanGroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @chan_group }
      format.js { render :layout => false }
    end
  end

  # GET /chan_groups/1/edit
  def edit
  end

  # POST /chan_groups
  # POST /chan_groups.json
  def create
    @chan_group = ChanGroup.new(params[:chan_group])

    respond_with(@chan_group, :location => chan_groups_path) do |format|
      if @chan_group.save
        format.html { redirect_to chan_groups_path, notice: 'Chan group was successfully created.' }
        format.json { render json: @chan_group, status: :created, location: @chan_group }
        format.js { render :text => "window.location = '#{chan_groups_path}'", notice: 'Chan group was successfully created.' }
      else
        format.html { render action: "new" }
        format.json { render json: @chan_group.errors, status: :unprocessable_entity }
        format.js { render action: "new", layout: false }
      end
    end
  end

  # PUT /chan_groups/1
  # PUT /chan_groups/1.json
  def update

    respond_to do |format|
      if @chan_group.update_attributes(params[:chan_group])
        format.html { redirect_to @chan_group, notice: 'Chan group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @chan_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chan_groups/1
  # DELETE /chan_groups/1.json
  def destroy

    @chan_group.destroy

    respond_to do |format|
      format.html { redirect_to chan_groups_url }
      format.js { render :text => "$('##{dom_id(@chan_group)}').remove();" }
      format.json { head :no_content }
    end
  end

  private

  def find_group
    @chan_group = ChanGroup.find(params[:id])
  end
end
