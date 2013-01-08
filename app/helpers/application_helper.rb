module ApplicationHelper
  include ActionView::Helpers::UrlHelper

	def icon(class_name)
		case class_name
      when "Page" then "content-page"
      when "Link" then "link"
      when "Folder" then "folder"
      else "gallery"
	  end
	end

	def navlink(site,item)

		class_name = item.class.name

    if class_name ==  "Page" 
    	link_to item.name, admin_site_page_path(site, item), class: 'ajax'
    else 
      item.name
	  end
	end

end
