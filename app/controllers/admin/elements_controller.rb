class Admin::ElementsController < ApplicationController
	def remove
		@element = Element.find(params[:id])
		@element.child.destroy
		@element.destroy
		respond_to do |format|
			format.js {}
		end
	end
end
