class HomepagesController < ApplicationController
	def show
		@site = Site.find(params[:id])
		@homepage = @site.homepage
  	@nav_items = @site.nav_items.pos
  	render layout: 'site'
	end
end
