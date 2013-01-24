class Admin::GalleriesController < ApplicationController
	
  before_filter :authenticate_user!
	before_filter :get_site

  def index
    @galleries = @site.galleries
  end

  def show
    @image = Image.new
    @page = Page.new
    @nav_items = @site.nav_items.includes(:navable).nav_scope
    @gallery_items = @site.nav_items.includes(:navable).gallery_scope
    @gallery = @site.galleries.find(params[:id])

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

  def new
    @gallery = Gallery.new
    render :layout => false
  end

  def edit
    @gallery = @site.galleries.find(params[:id])
    render :layout => false
  end

  def create
    @gallery = @site.galleries.new(params[:gallery])
    if @gallery.save
      # insert new item after the last top level nav item
      n = @site.nav_items.new(navable:@gallery)
      n.nav = false
      if @site.nav_items.gallery_scope.size > 0
        n.position = @site.nav_items.gallery_scope.last.position + 1
      end
      n.save

      redirect_to :back
      #redirect_to admin_site_pages_path, notice: 'Page was successfully created.'   
    else
      render action: "new" 
    end
  end

  def update
    @gallery = @site.galleries.find(params[:id])
    if @gallery.update_attributes(params[:gallery])
      redirect_to admin_site_gallery_path(@site,@gallery) #, notice: 'Gallery was successfully updated.'
    else
      render action: "edit" 
    end
  end

  def destroy
    @gallery = @site.galleries.find(params[:id])
    @gallery.destroy
    redirect_to admin_site_path(@site)
  end

  private

  def get_site 
    @site = Site.find(params[:site_id])
  end

end
