module ApplicationHelper

	def icon(class_name)
		case class_name
      when "Page" then "content-page"
      when "Link" then "link"
      when "Folder" then "folder"
      else "gallery"
	  end
	end

	def navlink(item)

		class_name = item.class.name

		case class_name
      when "Page" then "#{link_to nav_item.navable.name, admin_site_page_path(@site, nav_item.navable), class: 'ajax'}"
      else "#{nav_item.navable.name}"
	  end
	end

end
