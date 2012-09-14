module UsersHelper
  def grant_link(user, icon_class = nil)
    link_to (" #{content_tag(:i, '', :class => icon_class)} Admin Role").html_safe, grant_user_path(user, :role => 'admin'), :method => :post
  end

  def switch_link(user, icon_class = nil)
    link_to (" #{content_tag(:i, '', :class => icon_class)} Login As").html_safe, switch_user_path(user), :method => :post
  end

  def link_to_original_user
    unless session[:user_id_was].blank?
      link_to('Back to Admin', switch_user_path(session[:user_id_was]), :method => :post, :style => 'color: red;')
    end
  end
end
