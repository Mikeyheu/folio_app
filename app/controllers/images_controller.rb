class ImagesController < ApplicationController
  
  before_filter :get_site
  # before_filter :get_gallery

  def index
    @images = @site.images

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @images }
    end
  end

  def show
    @image = @site.images.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @image }
    end
  end

  def new
    @image = Image.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @image }
    end
  end

  def edit
    @image = @site.images.find(params[:id])
  end

  def create
    @image = @site.images.new(params[:image])
    @gallery = Gallery.find(params[:gallery_id])

    if @image.save
      rel = @gallery.gallery_assignments.new(image_id:@image.id)
      rel.save
      redirect_to site_gallery_path(@site,@gallery), notice: 'Image was successfully created.'
    else
      redirect_to site_gallery_path(@site,@gallery), notice: 'Image was not saved.'
    end
  end

  def update
    @image = @site.images.find(params[:id])

    respond_to do |format|
      if @image.update_attributes(params[:image])
        format.html { redirect_to site_image_path(@site,@image), notice: 'Image was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @image = @site.images.find(params[:id])
    @image.destroy

    respond_to do |format|
      format.html { redirect_to images_url }
      format.json { head :no_content }
    end
  end

  def sort
    
    gallery = Gallery.find(params[:gallery_id])
    array = params[:images].gsub('image[]=', '').split('&')
    array.each_with_index do |id, index|
      image = Image.find(id.to_i)
      # need to find the relationship
      gallery_assignment = image.gallery_assignments.where(gallery_id: gallery.id)
      gallery_assignment[0].position = index
      gallery_assignment[0].save
    end

     render :nothing => true
  end

  private

  def get_site 
    @site = Site.find(params[:site_id])
  end

  def get_gallery
    @gallery = Gallery.find(params[:id])
  end
end
