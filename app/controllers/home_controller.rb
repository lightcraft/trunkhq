class HomeController < ApplicationController
  def index
    if current_user
      # move user to places list
      redirect_to user_locations_path(current_user)
    end
  end

  def report
    @from = Date.parse(params[:from_date]) rescue Date.today.at_beginning_of_month()
    @to = Date.parse(params[:to_date]) rescue Date.today

    @prefix_groups = {}
    @prefix_rates = {}

    PrefixGroup.all.each do |prefix|
      @prefix_groups.merge!({prefix.id => prefix.group_name})
      @prefix_rates.merge!({prefix.id => prefix.def_rate})
    end

   # switch user if have access and provider ID present
    @user = (current_user.has_admin? && !params[:id].blank?) ?
      Provider.find_by_id(params[:id]) :
      current_user

    @groups_bill = @user.report(@from, @to)
  end

  def sys_log
    unless current_user.has_admin?
      redirect_to(root_path, :alert => '403 Permission denied!')
    end
  end
end
