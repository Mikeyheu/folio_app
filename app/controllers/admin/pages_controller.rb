class Admin::PagesController < ApplicationController
	
  before_filter :authenticate_user!
  before_filter :get_site

	def index
    @pages = @site.pages
  end

  def show
    @page = @site.pages.find(params[:id])
  end

  def new
    @page = Page.new
  end

  def edit
    @page = @site.pages.find(params[:id])
  end

  def create
    # @page = Page.new(params[:Page])

    @page = @site.pages.new(params[:page])

    if @page.save
      @site.nav_items.create(navable:@page)
      redirect_to admin_site_pages_path, notice: 'Page was successfully created.'   
    else
      render action: "new" 
    end
  end

  def update
    @page = @site.pages.find(params[:id])
    if @page.update_attributes(params[:Page])
			redirect_to admin_site_pages_path, notice: 'Page was successfully updated.'
    else
			render action: "edit" 
		end
  end

  def destroy
    @page = @site.pages.find(params[:id])
    @page.destroy
		redirect_to admin_site_pages_path
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
