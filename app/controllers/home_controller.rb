class HomeController < ApplicationController
  def index
    if current_user
      # move user to places list
      redirect_to user_locations_path(current_user)
    end
  end

  def report
    @from = Date.parse(params[:from_date]) rescue Date.today
    @to = Date.parse(params[:to_date]) + 1.day rescue Date.tomorrow()

    # switch user if have access and provider ID present
    @user = (current_user.has_admin? && !params[:id].blank?) ?
        Provider.find_by_id(params[:id]) :
        current_user

    group_price = @user.has_provider? ? PrefixGroupsForProvider : PrefixGroup

    @prefix_groups = {}
    @prefix_rates = {}

    group_price.all.each do |prefix|
      @prefix_groups.merge!({prefix.id => prefix.group_name})
      @prefix_rates.merge!({prefix.id => prefix.def_rate})
    end

    logger.info("@prefix_groups #{@prefix_groups.inspect}")
    logger.info("@prefix_rates #{@prefix_rates.inspect}")

    @groups_bill = @user.report(@from, @to, params[:location_id])
  end

  def sys_log
    unless current_user.has_admin?
      redirect_to(root_path, :alert => '403 Permission denied!')
    end
  end
end
