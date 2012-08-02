class HomeController < ApplicationController
  def index
    if current_user
      # move user to places list
      redirect_to user_locations_path(current_user)
    end
  end
end
