class PrefixGroupsController < ApplicationController
  load_and_authorize_resource :prefix_group
  before_filter :authenticate_user!
  before_filter :find_group, :only => [:show, :edit, :update, :destroy]
  respond_to :html, :json, :js

  # GET /prefix_groups
  # GET /prefix_groups.json
  def index
    @prefix_groups = PrefixGroup.order(:group_name).includes(:prefixes).page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @prefix_groups }
    end
  end

  # GET /prefix_groups/1
  # GET /prefix_groups/1.json
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @prefix_group }
    end
  end

  # GET /prefix_groups/new
  # GET /prefix_groups/new.json
  def new
    @prefix_group = PrefixGroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @prefix_group }
      format.js { render :layout => false }
    end
  end

  # GET /prefix_groups/1/edit
  def edit
    respond_to do |format|
      format.html #
      format.js { render layout: false }
    end
  end

  # POST /prefix_groups
  # POST /prefix_groups.json
  def create
    @prefix_group = PrefixGroup.new(params[:prefix_group])

    respond_with(@prefix_group, :location => prefix_groups_path) do |format|
      if @prefix_group.save
        format.html { redirect_to @prefix_group, notice: 'Prefix group was successfully created.' }
        format.json { render json: @prefix_group, status: :created, location: @prefix_group }
        format.js { render :text => "window.location = '#{prefix_groups_path}'", notice: 'Prefix Group was successfully created.' }
      else
        format.html { render action: "new" }
        format.json { render json: @prefix_group.errors, status: :unprocessable_entity }
        format.js { render action: "new", layout: false }
      end
    end
  end

  # PUT /prefix_groups/1
  # PUT /prefix_groups/1.json
  def update

    respond_to do |format|
      if @prefix_group.update_attributes(params[:prefix_group])
        format.html { redirect_to prefix_groups_path, notice: 'Prefix group was successfully updated.' }
        format.json { head :no_content }
        format.js { render :text => "window.location = '#{prefix_groups_path}'", notice: 'Prefix Group was successfully updated.' }
      else
        format.html { render action: "edit" }
        format.json { render json: @prefix_group.errors, status: :unprocessable_entity }
        format.js { render action: "edit", layout: false }
      end
    end
  end

  # DELETE /prefix_groups/1
  # DELETE /prefix_groups/1.json
  def destroy
    @prefix_group.destroy

    respond_to do |format|
      format.html { redirect_to prefix_groups_url }
      format.json { head :no_content }
      format.js { render :text => "$('##{dom_id(@prefix_group)}').remove();" }
    end
  end

  private
  def find_group
    @prefix_group = PrefixGroup.find(params[:id])
  end
end
