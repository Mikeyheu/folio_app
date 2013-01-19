class GalleriesController < ApplicationController

  before_filter :get_site

  def show
  	@nav_items = @site.nav_items.includes(:navable).pos
    @gallery = @site.galleries.find(params[:id])
    render layout: 'site'
  end

  private

  def get_site 
    @site = Site.find(params[:site_id])
  end
  
end