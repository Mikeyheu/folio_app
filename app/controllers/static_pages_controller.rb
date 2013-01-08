class StaticPagesController < ApplicationController
  def home
  	render layout: 'static'
  end

  def about
  	render layout: 'static'
  end
end
