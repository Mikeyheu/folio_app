class Admin::SitesController < ApplicationController

  before_filter :authenticate_user!
  # before_filter :get_user

	def index
    @sites = current_user.sites
  end

  def show
    @site = Site.find(params[:id])
    @nav_items = @site.nav_items.includes(:navable).nav_scope
    @gallery_items = @site.nav_items.includes(:navable).gallery_scope
    @page = Page.new
    @image = Image.new
    render layout: 'admin_content'
  end

  def new
    @site = Site.new
    render :layout => false
  end

  def edit
    @site = Site.find(params[:id])
  end

  def create
    @site = current_user.sites.new(params[:site])
    if @site.save
      # create settings for has_one relationship - need to use @site.create_setting()
      @setting = @site.create_setting(title:@site.name)
      redirect_to admin_sites_path, notice: 'Site was successfully created.'   
    else
      render action: "new" 
    end
  end

  def update
    @site = Site.find(params[:id])
    if @site.update_attributes(params[:site])
			redirect_to admin_sites_path, notice: 'Site was successfully updated.'
    else
			render action: "edit" 
		end
  end

  def destroy
    @site = Site.find(params[:id])
    @site.destroy
		redirect_to admin_sites_path
  end

  def sort
    array1 = params[:nav_items].gsub('nav_item[', '').gsub(']=', ',').split('&')
    array2 = params[:gallery_items].gsub('nav_item[', '').gsub(']=', ',').split('&')
 
    array1.each_with_index do |item, index|
      a = item.split(',')
      n = NavItem.find(a[0].to_i)
      if a[1] == "null"
        n.parent_id = nil
      else 
        n.parent_id = a[1].to_i
      end
      n.position = index
      n.nav = true
      n.save
    end

    array2.each_with_index do |item, index|
      a = item.split(',')
      n = NavItem.find(a[0].to_i)
      if a[1] == "null"
        n.parent_id = nil
      else 
        n.parent_id = a[1].to_i
      end
      n.position = index
      n.nav = false
      n.save
    end

    render :nothing => true
  end

  private

  # def get_user
  #   if current_user
  #     @user = current_user
  #   else
  #     redirect_to new_user_session_path
  #   end
  # end

end
