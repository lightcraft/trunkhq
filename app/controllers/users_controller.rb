class UsersController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :xml, :json

  def index
    authorize! :index, @user, :message => 'Not authorized as an administrator.'
    @users = User.includes(:roles).page(params[:page]).per(10)
    @first_admin = Role.first_admin
  end

  def show
    @user = User.find(params[:id])
    authorize! :read, @user
  end

  def grant
    role = params[:role].to_sym
    @user = User.find(params[:id])
    @user.has_role?(role) ?
        @user.remove_role(role) :
        @user.add_role(role)  #:admin
    respond_with(@user) do |format|
      format.html { redirect_to :back }
      format.js { }
    end
  end

end
