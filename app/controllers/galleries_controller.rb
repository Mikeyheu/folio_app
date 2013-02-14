class GalleriesController < ApplicationController

  before_filter :get_site

  def show
  	@nav_items = @site.nav_items.includes(:navable).nav_scope
    @gallery = @site.galleries.find(params[:id])
    render layout: 'site'
  end

  private

  def get_site 
    @site = Site.find(params[:site_id])
  end
  
end