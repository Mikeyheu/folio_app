class Admin::PagesController < ApplicationController
	
  before_filter :authenticate_user!
  before_filter :get_site

	def index
    @pages = @site.pages
  end

  def show
    @image = Image.new
    @page = @site.pages.find(params[:id])
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
    if @page.update_attributes(params[:Page])
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

def sort
  array = params[:pages].gsub('page[', '').gsub(']=', ',').split('&')

  array.each_with_index do |item, index|
  	a = item.split(',')
  	p = Page.find(a[0].to_i)
  	if a[1] == "null"
  		p.parent_id = nil
  	else 
  		p.parent_id = a[1].to_i
  	end
  	p.position = index
  	p.save
  end

	   render :nothing => true
	end

  private

  def get_site 
    @site = Site.find(params[:site_id])
  end

end
