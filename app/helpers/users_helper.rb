module UsersHelper
  def grant_link(user, icon_class = nil)
    link_to (" #{content_tag(:i, '', :class => icon_class)} Admin Role").html_safe, grant_user_path(user, :role => 'admin'), :method => :post
  end
end
