class Admin::FoldersController < ApplicationController

  before_filter :authenticate_user!
  before_filter :get_site

  def new
    @folder = Folder.new
    render :layout => false
  end

  def create
    @folder = @site.folders.new(params[:folder])

    if @folder.save
      
      n = @site.nav_items.create(navable:@folder)
      n.nav = true
      if @site.nav_items.size > 0
        parents = @site.nav_items.select { |n| n.parent_id == nil }
        last_nav_item = parents.max {|a,b| a.position <=> b.position }
        n.position = last_nav_item.position + 1
      end
      n.save
      
      redirect_to :back
      
    else
      render action: "new" 
    end
  end

  def update
    @folder = @site.folders.find(params[:id])
    if @folder.update_attributes(params[:folder])
      redirect_to :back
    else
      render action: "edit" 
    end
  end

  def edit
    @folder = @site.folders.find(params[:id])
    render :layout => false
  end

  def destroy
    @folder = @site.folders.find(params[:id])
    @folder.nav_item.children.each do |nav_item|
      nav_item.parent_id = nil
    end
    @folder.destroy
    redirect_to admin_site_path(@site)
  end

end