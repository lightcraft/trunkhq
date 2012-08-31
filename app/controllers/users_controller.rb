class UsersController < ApplicationController
  load_and_authorize_resource :user
  before_filter :authenticate_user!
  respond_to :html, :json

  def index
    @users = User.includes(:roles).where('roles.name IN (?)', ['user', 'admin']).page(params[:page]).per(10)
    @first_admin = Role.first_admin
  end

  def show
    @user = User.find(params[:id])
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
