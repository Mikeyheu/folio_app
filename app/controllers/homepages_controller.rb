class HomepagesController < ApplicationController
	def show
		@site = Site.find(params[:id])
		@homepage = @site.homepage
  	@nav_items = @site.nav_items.includes(:navable).nav_scope
  	render layout: 'site'
	end
end
