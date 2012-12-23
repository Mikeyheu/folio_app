class PagesController < ApplicationController

	def index
  	@pages = @site.pages
  end

  def show
  	@page = Page.find(params[:id])
  end
  
end
