class IvrsController < ApplicationController
  load_and_authorize_resource :chan_group
  before_filter :authenticate_user!

  # GET /ivrs
  # GET /ivrs.json
  def index
    @ivrs = Ivr.order(:id).page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ivrs }
    end
  end

  # GET /ivrs/1
  # GET /ivrs/1.json
  def show
    @ivr = Ivr.find(params[:id])

    respond_to do |format|
      format.html { redirect_to ivrs_url }# show.html.erb
      format.json { render json: @ivr }
    end
  end

  # GET /ivrs/new
  # GET /ivrs/new.json
  def new
    @ivr = Ivr.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ivr }
    end
  end

  # GET /ivrs/1/edit
  def edit
    @ivr = Ivr.find(params[:id])
  end

  # POST /ivrs
  # POST /ivrs.json
  def create
    @ivr = Ivr.new(params[:ivr])

    respond_to do |format|
      if @ivr.save
        format.html { redirect_to ivrs_url, notice: 'Ivr was successfully created.' }
        format.json { render json: @ivr, status: :created, location: @ivr }
      else
        format.html { render action: "new" }
        format.json { render json: @ivr.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ivrs/1
  # PUT /ivrs/1.json
  def update
    @ivr = Ivr.find(params[:id])

    respond_to do |format|
      if @ivr.update_attributes(params[:ivr])
        format.html { redirect_to ivrs_url, notice: 'Ivr was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ivr.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ivrs/1
  # DELETE /ivrs/1.json
  def destroy
    @ivr = Ivr.find(params[:id])
    @ivr.destroy

    respond_to do |format|
      format.html { redirect_to ivrs_url }
      format.json { head :no_content }
    end
  end
end
