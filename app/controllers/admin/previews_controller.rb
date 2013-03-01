class Admin::PreviewsController < ApplicationController

	before_filter :authenticate_user!
  before_filter :get_site

	def show

  	
  	@nav_items = @site.nav_items.includes(:navable).nav_scope
  	@page = @nav_items.first.navable
    if request.headers['X-PJAX']
      render :layout => false
    else 
      respond_to do |format| 
        format.html { render layout: 'site' }
        format.js {}
      end
    end
	end
end