class GalleriesController < ApplicationController

  before_filter :get_site

  def index
    @galleries = @site.galleries
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @galleries }
    end
  end

  def show
    @image = Image.new
    @gallery = @site.galleries.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @gallery }
    end
  end

  def new
    @gallery = Gallery.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @gallery }
    end
  end

  def edit
    @gallery = @site.galleries.find(params[:id])
  end

  def create
    @gallery = @site.galleries.new(params[:gallery])

    respond_to do |format|
      if @gallery.save
        format.html { redirect_to site_gallery_path(@site,@gallery), notice: 'Gallery was successfully created.' }
        format.json { render json: site_gallery_path(@site,@gallery), status: :created, location: @gallery }
      else
        format.html { render action: "new" }
        format.json { render json: site_gallery_path(@site,@gallery).errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @gallery = @site.galleries.find(params[:id])

    respond_to do |format|
      if @gallery.update_attributes(params[:gallery])
        format.html { redirect_to site_gallery_path(@site,@gallery), notice: 'Gallery was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: site_gallery_path(@site,@gallery).errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @gallery = @site.galleries.find(params[:id])
    @gallery.destroy

    respond_to do |format|
      format.html { redirect_to site_galleries_path }
      format.json { head :no_content }
    end
  end

  private

  def get_site 
    @site = Site.find(params[:site_id])
  end
end