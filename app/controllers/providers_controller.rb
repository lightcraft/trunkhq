class ProvidersController < ApplicationController
  load_and_authorize_resource :provider
    before_filter :authenticate_user!
  before_filter :find_provider, :only => [:destroy, :show, :edit, :update]
  respond_to :html, :json, :js


  # GET /providers
  # GET /providers.json
  def index
    authorize! :index, Provider, :message => 'Not authorized as an administrator.'
    @providers = Provider.includes(:roles).where('roles.name = ?', 'provider').page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @providers }
    end
  end

  # GET /providers/1
  # GET /providers/1.json
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @provider }
    end
  end

  # GET /providers/new
  # GET /providers/new.json
  def new
    @provider = Provider.new
    @prefix_groups = PrefixGroup.order(:group_name).all
    groups = @prefix_groups.collect { |group| {
        name: group.group_name,
        prefix_groups_for_provider_id: group.id,
        start_date: Date.today.to_s(:date),
        rate: 0,
        allowed_minutes: 0,
        enabled: true
    } }
    @provider.user_prefix_groups.build(groups)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @provider }
      format.js { render :layout => false }
    end
  end

  # GET /providers/1/edit
  def edit
    respond_to do |format|
      format.js { render :layout => false }
    end
  end

  # POST /providers
  # POST /providers.json
  def create
    @provider = Provider.new(params[:provider])
    #logger.debug(@provider.inspect)
    #logger.debug(@provider.user_prefix_groups.first.inspect)
    respond_to do |format|
      if @provider.save
        format.html { redirect_to providers_path, notice: 'Provider was successfully created.' }
        format.json { render json: @provider, status: :created, location: @provider }
        format.js { render :text => "window.location = '#{providers_path}'", notice: 'Provider was successfully created.' }
      else
        format.html { render action: "new" }
        format.json { render json: @provider.errors, status: :unprocessable_entity }
        format.js { render action: "new", layout: false }
      end
    end
  end

  # PUT /providers/1
  # PUT /providers/1.json
  def update

    respond_to do |format|
      if @provider.update_attributes(params[:provider])
        format.html { redirect_to providers_path, notice: 'Provider was successfully updated.' }
        format.json { head :no_content }
        format.js {
          render :text => "window.location = '#{providers_path}'", notice: 'Provider was successfully created.'
        }
      else
        format.html { render action: "edit" }
        format.json { render json: @provider.errors, status: :unprocessable_entity }
        format.js { render action: 'edit', layout: false }
      end
    end
  end

  # DELETE /providers/1
  # DELETE /providers/1.json
  def destroy
    @provider.destroy
    respond_to do |format|
      format.html { redirect_to providers_url }
      format.json { head :no_content }
      format.js { render :text => "window.location = '#{providers_path}'" }

    end
  end

  private

  def find_provider
    @provider = Provider.find(params[:id])
  end
end
