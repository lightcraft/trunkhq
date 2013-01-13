class CdrController < ApplicationController
  load_and_authorize_resource :user
  before_filter :authenticate_user!

  def index
    @cdrs = Cdr.includes(:prefix_group, :channel, :location).order('cdr.calldate desc')
    @cdrs = @cdrs.where("lower(cdr.disposition) = ?", session[:cdr_filter]) if session[:cdr_filter]
    @cdrs = @cdrs.where('cdr.channel_id = ? ', params[:channel_id]) unless params[:channel_id].blank?

    #date conditions
    @date_filter = params[:date_filter]
    @date_filter ||= Date.today.to_s(:date)
    @cdrs = @cdrs.where('cdr.calldate > ? AND cdr.calldate < ?', Date.parse(@date_filter).at_beginning_of_day, Date.parse(@date_filter).end_of_day)

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
