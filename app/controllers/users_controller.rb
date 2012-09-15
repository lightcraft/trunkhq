class UsersController < ApplicationController
  load_and_authorize_resource :user
  before_filter :authenticate_user!
  before_filter :find_user, :only => [:grant, :swith]
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

    @user.has_role?(role) ?
        @user.remove_role(role) :
        @user.add_role(role) #:admin
    respond_with(@user) do |format|
      format.html { redirect_to :back }
      format.js {}
    end
  end

  def switch
    if current_user.has_admin? || !session[:user_id_was].blank?
      session[:user_id_was] = current_user.id if current_user.has_admin?
      # session["warden.user.user.key"] => ["User", [3], "$2a$10$m0Hz2gVUm4B/FQuLxLEQvO"]
      env['warden'].set_user(@user)
      session[:user_id_was] = nil if @user.has_admin?

      redirect_to root_path, :alert => (@user.has_admin? ? 'Welcome GOD!' : 'Switch to User' )
    end
  end

  private
  def find_user
    @user = User.find(params[:id])
  end
end
