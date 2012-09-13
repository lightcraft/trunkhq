class HomeController < ApplicationController
  def index
    if current_user
      # move user to places list
      redirect_to user_locations_path(current_user)
    end
  end

  def report

  end

  def sys_log
    unless current_user.has_admin?
      redirect_to(root_path, :alert => '403 Permission denied!')
    end
  end
end
