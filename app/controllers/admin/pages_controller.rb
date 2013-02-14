class Admin::PagesController < ApplicationController
	
  before_filter :authenticate_user!
  before_filter :get_site

	def index
    @pages = @site.pages
  end

  def show
    @image = Image.new
    @page = @site.pages.find(params[:id])
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
  end

  def new
    @page = Page.new
    render :layout => false
  end

  def edit
    @page = @site.pages.find(params[:id])
    render :layout => false
  end

  def create
    # @page = Page.new(params[:Page])

    @page = @site.pages.new(params[:page])

    if @page.save
      # insert new item after the last top level nav item
      n = @site.nav_items.new(navable:@page)
      n.nav = true
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
    @page = @site.pages.find(params[:id])
    if @page.update_attributes(params[:page])
      redirect_to :back
			#redirect_to admin_site_pages_path, notice: 'Page was successfully updated.'
    else
			render action: "edit" 
		end
  end

  def destroy
    @page = @site.pages.find(params[:id])
    @page.destroy
		redirect_to admin_site_path(@site)
  end

  def add_text_element
    @page = @site.pages.find(params[:id])
    text = PageText.create(content:"Enter your text here.")
    @page.elements.create(child:text, top:0, left:0, width:200, height:30)
    redirect_to :back
  end

end
