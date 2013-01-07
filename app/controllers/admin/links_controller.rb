class Admin::LinksController < ApplicationController
	
  before_filter :authenticate_user!
  before_filter :get_site

  def new
    @link = Link.new
    render :layout => false
  end

  def edit
    @link = @site.links.find(params[:id])
  end

  def create
    # @link = Link.new(params[:link])

    @link = @site.links.new(params[:link])

    if @link.save
      # insert new item after the last top level nav item
      n = @site.nav_items.create(navable:@link)
      if (@site.nav_items.size > 0
        parents = @site.nav_items.select { |n| n.parent_id == nil }
        last_nav_item = parents.max {|a,b| a.position <=> b.position }
        n.position = last_nav_item.position + 1
      end
      n.save
      
      redirect_to :back
      #redirect_to admin_sites_path, notice: 'link was successfully created.'   
    else
      render action: "new" 
    end
  end

  def update
    @link = @site.links.find(params[:id])
    if @link.update_attributes(params[:link])
			redirect_to :back
      #redirect_to admin_sites_path, notice: 'link was successfully updated.'
    else
			render action: "edit" 
		end
  end

  def destroy
    @link = @site.links.find(params[:id])
    @link.destroy
		redirect_to admin_site_path
  end

  private

  def get_site 
    @site = Site.find(params[:site_id])
  end

end
