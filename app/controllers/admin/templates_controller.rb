class Admin::TemplatesController < ApplicationController
	before_filter :authenticate_user!
  before_filter :get_site

	def show
		@templates = Template.all
		@template = @site.template
		
		if request.headers['X-PJAX']
      render :layout => false
    else 
      respond_to do |format| 
        format.html { render layout: 'admin_design' }
        format.js {}
      end
    end
	end

	def update_template
		id = params[:template].gsub('template_','').to_i
    if @site.site_template.update_attributes(template_id:id)
    	redirect_to :back
    end
	end

	private

end

