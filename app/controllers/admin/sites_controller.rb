class Admin::SitesController < ApplicationController

  before_filter :authenticate_user!
  # before_filter :get_user

	def index
    @sites = current_user.sites
  end

  def show
    @site = Site.find(params[:id])
  end

  def new
    @site = Site.new
  end

  def edit
    @site = Site.find(params[:id])
  end

  def create
    # @site = Site.new(params[:site])

    @site = current_user.sites.new(params[:site])

    if @site.save
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

  private

  # def get_user
  #   if current_user
  #     @user = current_user
  #   else
  #     redirect_to new_user_session_path
  #   end
  # end

end
