class PagesController < ApplicationController

	def index
  	@pages = @site.pages
  end

  def show
  	@page = Page.find(params[:id])
  	@site = Site.find(params[:site_id])
  	@nav_items = @site.nav_items.pos
  	render layout: 'site'
  end
  
end
