class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
 		admin_sites_path
  end
  
  def get_site 
    @site = Site.find(params[:site_id])
  end

end
