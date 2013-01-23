class Admin::GalleryPagesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_site

	def index
    @gallery_pages = @site.gallery_pages
  end

  def show
    @image = Image.new
    @gallery_page = @site.gallery_pages.find(params[:id])
    @nav_items = @site.nav_items.includes([:navable, :parent, :children]).pos
    
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
    @gallery_page = GalleryPage.new
    render :layout => false
  end

  def edit
    @gallery_page = @site.gallery_pages.find(params[:id])
    render :layout => false
  end

  def create
    @gallery_page = @site.gallery_pages.new(params[:gallery_page])

    if @gallery_page.save
      # insert new item after the last top level nav item
      n = @site.nav_items.new(navable:@gallery_page)
      if @site.nav_items.size > 0
        parents = @site.nav_items.select { |n| n.parent_id == nil }
        last_nav_item = parents.max {|a,b| a.position <=> b.position }
        n.position = last_nav_item.position + 1
      end
      n.save

      redirect_to :back
      #redirect_to admin_site_pages_path, notice: 'Page was successfully created.'   
    else
      render action: "new" 
    end
  end

   def update
    @gallery_page = @site.gallery_pages.find(params[:id])
    if @gallery_page.update_attributes(params[:gallery_page])
      redirect_to :back
			#redirect_to admin_site_pages_path, notice: 'Page was successfully updated.'
    else
			render action: "edit" 
		end
  end

  def destroy
    @gallery_page = @site.gallery_pages.find(params[:id])
    @gallery_page.destroy
		redirect_to admin_site_path(@site)
  end

	private

  def get_site 
    @site = Site.find(params[:site_id])
  end
end
