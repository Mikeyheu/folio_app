class Admin::ImagesController < ApplicationController
  before_filter :authenticate_user!
	before_filter :get_site

  def index
    @images = @site.images
  end

  def show
    @image = @site.images.find(params[:id])
  end

  def new
    @image = Image.new
  end

  def edit
    @image = @site.images.find(params[:id])
  end

  def create
    @image = @site.images.new(params[:image])
    @gallery = Gallery.find(params[:gallery_id])

    if @image.save

      # Add 1 to the position of each gallery_assignment of the gallery
      @gallery.gallery_assignments.each do |gallery_assignment|
        gallery_assignment.position = gallery_assignment.position + 1
        gallery_assignment.save
      end

      # Create new gallery_assignment
      ga = @gallery.gallery_assignments.new(image_id:@image.id)
      ga.save

      render :nothing => true
      
    end
  end

  def update
    @image = @site.images.find(params[:id])
      if @image.update_attributes(params[:image])
        redirect_to admin_site_image_path(@site,@image), notice: 'Image was successfully updated.' 
      else
        render action: "edit" 
      end
  end

  def destroy
    @image = @site.images.find(params[:id])
    @image.destroy

    redirect_to admin_site_galleries_path(@site)
  end

  def sort
    
    gallery = Gallery.find(params[:gallery_id])
    array = params[:images].gsub('image[]=', '').split('&')
    
    array.each_with_index do |id, index|
      image = Image.find(id.to_i)
      ga = GalleryAssignment.find_by_gallery_id_and_image_id(gallery.id, image.id)
      ga.position = index
      ga.save
    end

     render :nothing => true
  end

  private

  def get_site 
    @site = Site.find(params[:site_id])
  end

end
