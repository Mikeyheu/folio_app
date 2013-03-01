class Admin::HeadersController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :get_site 

  def show
    @header = @site.header
    
    if request.headers['X-PJAX']
      render :layout => false
    else 
      respond_to do |format| 
        format.html { render layout: 'admin_design' }
        format.js {}
      end
    end
  end

  def add_text_element
    @header = @site.header
    text = PageText.create(content:"Enter your text here.")
    @header.elements.create(child:text, top:0, left:0, width:200, height:30)
    redirect_to :back
  end

end