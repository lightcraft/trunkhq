
class PrefixGroupsForProvidersController < ApplicationController
  load_and_authorize_resource :prefix_groups_for_provider
  before_filter :authenticate_user!
  before_filter :find_group, :only => [:show, :edit, :update, :destroy]
  respond_to :html, :json, :js

  # GET /prefix_groups_for_provider
  # GET /prefix_groups_for_provider.json
  def index
    @prefix_groups = PrefixGroupsForProvider.order(:group_name).includes(:prefixes).page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @prefix_group }
    end
  end

  # GET /prefix_groups_for_provider/1
  # GET /prefix_groups_for_provider/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @prefix_group }
    end
  end

  # GET /prefix_groups_for_provider/new
  # GET /prefix_groups_for_provider/new.json
  def new
    @prefix_group = PrefixGroupsForProvider.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @prefix_group }
      format.js { render :layout => false }
    end
  end

  # GET /prefix_groups_for_provider/1/edit
  def edit
  end

  # POST /prefix_groups_for_provider
  # POST /prefix_groups_for_provider.json
  def create
    @prefix_group = PrefixGroupsForProvider.new(params[:prefix_groups_for_provider])

    respond_to do |format|
      if @prefix_group.save
        format.html { redirect_to prefix_groups_for_providers_url, notice: 'Prefix groups for provider was successfully created.' }
        format.json { render json: @prefix_group, status: :created, location: @prefix_group }
        format.js { render :text => "window.location = '#{prefix_groups_for_providers_url}'", notice: 'Prefix Group was successfully created.' }
      else
        format.html { render action: "new" }
        format.json { render json: @prefix_group.errors, status: :unprocessable_entity }
        format.js { render action: "new", layout: false }
      end
    end
  end

  # PUT /prefix_groups_for_provider/1
  # PUT /prefix_groups_for_provider/1.json
  def update
    respond_to do |format|
      if @prefix_group.update_attributes(params[:prefix_groups_for_provider])
        format.html { redirect_to @prefix_group, notice: 'Prefix groups for provider was successfully updated.' }
        format.json { head :no_content }
        format.js { render :text => "window.location = '#{prefix_groups_for_providers_url}'", notice: 'Prefix Group was successfully updated.' }
      else
        format.html { render action: "edit" }
        format.json { render json: @prefix_group.errors, status: :unprocessable_entity }
        format.js { render action: "edit", layout: false }
      end
    end
  end

  # DELETE /prefix_groups_for_provider/1
  # DELETE /prefix_groups_for_provider/1.json
  def destroy

    @prefix_group.destroy

    respond_to do |format|
      format.html { redirect_to prefix_groups_for_providers_url }
      format.json { head :no_content }
      format.js { render :text => "$('##{dom_id(@prefix_group)}').remove();" }
    end
  end

  private

  def find_group
    @prefix_group = PrefixGroupsForProvider.find(params[:id])
  end
end
