
class PrefixesController < ApplicationController
  load_and_authorize_resource :prefix
  before_filter :authenticate_user!
  before_filter :find_prefix, :only => [:show, :edit, :update, :destroy]
  respond_to :html, :json, :js


  # GET /prefixes
  # GET /prefixes.json
  def index
    @prefixes = Prefix.order(:prefix_group_id).includes(:prefix_group, :prefix_groups_for_provider).page(params[:page]).per(50)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @prefixes }
    end
  end

  # GET /prefixes/1
  # GET /prefixes/1.json
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @prefix }
    end
  end

  # GET /prefixes/new
  # GET /prefixes/new.json
  def new
    @prefix = Prefix.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @prefix }
      format.js { render :layout => false }
    end
  end

  # GET /prefixes/1/edit
  def edit
    respond_to do |format|
      format.html #
      format.js { render layout: false }
    end
  end

  # POST /prefixes
  # POST /prefixes.json
  def create
    @prefix = Prefix.new(params[:prefix])

    respond_to do |format|
      if @prefix.save
        format.html { redirect_to prefixes_url, notice: 'Prefix was successfully created.' }
        format.json { render json: @prefix, status: :created, location: @prefix }
        format.js { render :text => "window.location = '#{prefixes_path}'", notice: 'Prefix was successfully created.' }
      else
        format.html { render action: "new" }
        format.json { render json: @prefix.errors, status: :unprocessable_entity }
        format.js { render action: "new", layout: false }
      end
    end
  end

  # PUT /prefixes/1
  # PUT /prefixes/1.json
  def update

    respond_to do |format|
      if @prefix.update_attributes(params[:prefix])
        format.html { redirect_to prefixes_url, notice: 'Prefix was successfully updated.' }
        format.json { head :no_content }
        format.js { render :text => "window.location = '#{prefixes_path}'", notice: 'Prefix was successfully updated.' }
      else
        format.html { render action: "edit" }
        format.json { render json: @prefix.errors, status: :unprocessable_entity }
        format.js { render action: "edit", layout: false }
      end
    end
  end

  # DELETE /prefixes/1
  # DELETE /prefixes/1.json
  def destroy
    @prefix.destroy

    respond_to do |format|
      format.html { redirect_to prefixes_url }
      format.json { head :no_content }
      format.js { render :text => "$('##{dom_id(@prefix)}').remove();" }
    end
  end

  private
  def find_prefix
    @prefix = Prefix.find(params[:id])
  end

end
