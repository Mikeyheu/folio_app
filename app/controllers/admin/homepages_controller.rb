class Admin::HomepagesController < ApplicationController
	before_filter :authenticate_user!
  before_filter :get_site

  def show
    @image = Image.new
    @homepage = @site.homepage
    @nav_items = @site.nav_items.includes(:navable).nav_scope
    @gallery_items = @site.nav_items.includes(:navable).gallery_scope
    if request.headers['X-PJAX']
      render :layout => false
    else 
      respond_to do |format| 
        format.html { render layout: 'admin_content' }
        format.js {}
      end
    end

    # respond_to do |format| 
    #   format.html { render layout: 'admin_content' }
    #   format.js {}
    # end
  end

  private

  def get_site 
    @site = Site.find(params[:site_id])
  end




end
