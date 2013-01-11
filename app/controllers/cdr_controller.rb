class CdrController < ApplicationController
  load_and_authorize_resource :user
  before_filter :authenticate_user!

  def index
    @cdrs = Cdr.includes(:user, :prefix_group, :channel, :location).order('cdr.calldate desc')
    @cdrs = @cdrs.where("lower(cdr.disposition) = ?", session[:cdr_filter]) if session[:cdr_filter]
    @cdrs = @cdrs.where('cdr.channel_id = ? ', params[:channel_id]) unless params[:channel_id].blank?

    @cdrs = @cdrs.page(params[:page]).per(20)
  end

  def set_filter
    case params[:filter]
      when 'all'
        session[:cdr_filter] = nil
      else
        session[:cdr_filter] = params[:filter]
    end

    redirect_to :back
  end
end
