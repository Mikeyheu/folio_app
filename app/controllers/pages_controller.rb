class PagesController < ApplicationController

	def index
  	@pages = @site.pages
  end

  def show
  	@page = Page.find(params[:id])
  	render layout: 'site'
  end
  
end
