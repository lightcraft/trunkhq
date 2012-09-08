module ChannelsHelper
  def channel_row_class(channel)
    return '' if channel.stop_date.blank?
    expired_days = (channel.stop_date - Date.today).to_i
    return '#f2dede' if expired_days < 0
    return '#b94a48' if expired_days.eql?(0)
    return '#3a87ad' if expired_days.eql?(1)
  end

  def edit_dom_id(obj)
    dom_id(obj, :edit)
  end

  def new_dom_id(obj)
    dom_id(obj, :new)
  end
end
