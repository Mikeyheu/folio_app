class Admin::SettingsController < ApplicationController

	before_filter :authenticate_user!
  before_filter :get_site

	def show
		@setting = @site.setting
		render layout: 'admin_settings'
	end

end
