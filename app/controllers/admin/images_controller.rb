class Admin::ImagesController < ApplicationController
  before_filter :authenticate_user!
	before_filter :get_site

  def index

    @images = @site.images
    @image = Image.new
    @page = Page.new
    # @nav_items = @site.nav_items.includes([:navable, :parent, :children]).pos
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

  def show
    @image = @site.images.find(params[:id])
  end

  def new
    @image = Image.new
    if params[:page_id]
      @page_id = params[:page_id]
    end
  end

  def edit
    @image = @site.images.find(params[:id])
    render :layout => false
  end

  def create

    @image = @site.images.new(params[:image])
    
    if @image.save
      if params[:gallery_id]
        @gallery = Gallery.find(params[:gallery_id])
        # Add 1 to the position of each gallery_assignment of the gallery
        @gallery.gallery_assignments.each do |gallery_assignment|
          gallery_assignment.position = gallery_assignment.position + 1
          gallery_assignment.save
        end
        # Create new gallery_assignment
        ga = @gallery.gallery_assignments.new(image_id:@image.id)
        ga.save

        render :nothing => true
      elsif params[:page_id]
        p = Page.find(params[:page_id])       
        p.elements.create(elementable:@image, top:100, left:100, width:200, height:200) 
        redirect_to :back
      end
      
    end
  end

  def update
    @image = @site.images.find(params[:id])
      if @image.update_attributes(params[:image])
        redirect_to admin_site_image_path(@site,@image)#, notice: 'Image was successfully updated.' 
      else
        render action: "edit" 
      end
  end

  def destroy
    @image = @site.images.find(params[:id])
    @image.destroy

    redirect_to :back

  end

  def remove
    gallery = Gallery.find(params[:gallery_id])
    @image = @site.images.find(params[:id])
    ga = GalleryAssignment.find_by_gallery_id_and_image_id(gallery.id, @image.id)
    ga.destroy

    respond_to do |format|
      format.js {}
    end

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

  def move_images
    gallery = Gallery.find(params[:gallery_id].gsub('gallery_', '').to_i)
    array = params[:images].gsub('image_', '').split('&')
    array.map! { |id| id.to_i }

    
    # remove existing images if they already exist
    array2 = gallery.images.map { |item| item.id }
    array.keep_if { |n| !array2.include?(n) }

    unless array.length == 0
      # Add the length of the array to the position of each gallery_assignment of the gallery
      gallery.gallery_assignments.each do |gallery_assignment|
        gallery_assignment.position = gallery_assignment.position + array.length
        gallery_assignment.save
      end

      array.each_with_index do |id, index|
        image = Image.find(id.to_i)
        ga = gallery.gallery_assignments.new(image_id:image.id)
        ga.position = index
        ga.save
      end
    end

    render :nothing => true
  end

  private

  def get_site 
    @site = Site.find(params[:site_id])
  end

end
