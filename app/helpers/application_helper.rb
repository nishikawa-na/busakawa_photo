module ApplicationHelper
  def check_login
    if logged_in?
      render 'shared/header_login' 
    else
      link_to root_path do
        image_tag "profile.png", class: "header_icon"
      end
    end
  end
end
