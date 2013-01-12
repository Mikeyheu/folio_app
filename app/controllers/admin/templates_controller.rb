class Admin::TemplatesController < ApplicationController
	before_filter :authenticate_user!
  before_filter :get_site

	def show
		@templates = Template.all
		@template = @site.template
		render layout: 'admin_design'
	end

	private

  def get_site 
    @site = Site.find(params[:site_id])
  end
end

