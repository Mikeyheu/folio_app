class SitesController < ApplicationController
  def show
  	@site = Site.find(params[:id])
  	
  	@nav_items = @site.nav_items.includes(:navable).nav_scope
  	@page = @nav_items.first.navable
    render layout: 'site'


  end
end


        
