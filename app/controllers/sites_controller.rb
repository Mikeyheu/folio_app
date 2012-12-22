class SitesController < ApplicationController
  def show
    @site = Site.find(params[:id])
    render layout: 'site'
  end
end
