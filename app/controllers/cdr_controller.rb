class CdrController < ApplicationController
  load_and_authorize_resource :user
  before_filter :authenticate_user!

  def index
    @cdrs = Cdr.includes(:user, :prefix_group, :channel, :location).order('cdr.calldate desc').scoped
    @cdrs = @cdrs.where('cdr.channel_id = ? ', params[:cannel_id]).scoped unless params[:channel_id].blank?

    @cdrs = @cdrs.page(params[:page]).per(20)
  end

end
