class GalleriesController < ApplicationController

  before_filter :get_site

  def show
    @gallery = @site.galleries.find(params[:id])
    render layout: 'site'
  end

  private

  def get_site 
    @site = Site.find(params[:site_id])
  end
  
end