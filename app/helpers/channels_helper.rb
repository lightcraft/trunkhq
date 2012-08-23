module ChannelsHelper
  #def _channel_form_path(channel)
  #  channel.new_recor
  #  [current_user.locations.first, @channel ||= Channel.new]
  #
  #end

  def edit_dom_id(obj)
    dom_id(obj, :edit)
  end

  def new_dom_id(obj)
    dom_id(obj, :new)
  end
end
